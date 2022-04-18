import XCTest
@testable import TwitchChat

final class MessageTests: XCTestCase {
    func testTagsParsingNoTagsIncludesSource() throws {
        try XCTAssertEqual(
          Message(string: ":irc.example.com CAP LS * :multi-prefix extended-join sasl").tags,
          [:]
        )
    }

    func testTagsParsingSingleTag() throws {
        try XCTAssertEqual(
          Message(string: "@id=234AB :dan!d@localhost PRIVMSG #chan :Hey what's up!").tags,
          ["id":"234AB"] 
        )
    }

    func testTagsParsingNoTagsNoSource() {
        try XCTAssertEqual(
          Message(string: "CAP REQ :sasl").tags,
          [:]
        )
    }

    func testSourceParsingNickname() throws {
        try XCTAssertEqual(
          Message(string: ":cocoatype!cocoatype@cocoatype.tmi.twitch.tv PRIVMSG #cocoatype :this is also a test?").sourceString,
          "cocoatype!cocoatype@cocoatype.tmi.twitch.tv"
        )
    }

    func testSourceParsingServer() throws {
        try XCTAssertEqual(
          Message(string: ":tmi.twitch.tv 001 cocoatype :Welcome, GLHF!").sourceString,
          "tmi.twitch.tv"
        )
    }

    func testParametersParsingEmptyFinalParameter() throws {
        try XCTAssertEqual(
          Message(string: ":irc.example.com CAP * LIST :").parameters,
          ["*", "LIST", ""]
        )
    }

    func testParametersParsingTwoWordFinalParameter() throws {
        try XCTAssertEqual(
          Message(string: "CAP * LS :multi-prefix sasl").parameters,
          ["*", "LS", "multi-prefix sasl"]
        )
    }

    func testParametersParsingThreeWordFinalParameter() throws {
        try XCTAssertEqual(
          Message(string: "CAP REQ :sasl message-tags foo").parameters,
          ["REQ", "sasl message-tags foo"]
        )
    }

    func testParametersParsingFinalParameterWithColon() throws {
        try XCTAssertEqual(
          Message(string: ":dan!d@localhost PRIVMSG #chan :Hey!").parameters,
          ["#chan", "Hey!"]
        )
    }

    func testParametersParsingFinalParameterWithoutColon() throws {
        try XCTAssertEqual(
          Message(string: ":dan!d@localhost PRIVMSG #chan Hey!").parameters,
          ["#chan", "Hey!"]
        )
    }

    func testParametersParsingMultipleColons() throws {
        try XCTAssertEqual(
          Message(string: ":dan!d@localhost PRIVMSG #chan ::-)").parameters,
          ["#chan", ":-)"]
        )
    }
}
