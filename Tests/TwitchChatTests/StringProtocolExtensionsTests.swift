import XCTest
@testable import TwitchChat

final class StringProtocolExtensionsTests: XCTestCase {
    func testRemovePrefixRemovesPrefix() {
        XCTAssertEqual(
            "!hello".removingPrefix("!"),
            "hello")
    }

    func testRemovePrefixReturnsOriginalWhenPrefixMissing() {
        XCTAssertEqual(
            "hello".removingPrefix("!"),
            "hello")
    }

    func testAppendingSomeOptional() {
        var string = "hello"
        string.append(String?(", world!"))
        XCTAssertEqual(
            string,
            "hello, world!"
        )
    }

    func testAppendingNoneOptional() {
        var string = "hello"
        string.append(String?.none)
        XCTAssertEqual(
            string,
            "hello"
        )
    }
}
