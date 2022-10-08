import Foundation

public struct Emote {
    private let identifier: String
    public let range: ClosedRange<Int>

    public var imageURL: URL {
        get throws {
            guard let url = URL(string: "https://static-cdn.jtvnw.net/emoticons/v1/\(identifier)/2.0") else { throw EmoteError.invalidImageURL }
            return url
        }
    }

    static func emotes(from string: String) -> [Emote] {
        let emoteDefinitions = string.split(separator: "/")
        return emoteDefinitions.flatMap { emotes(fromDefinition: $0) }
    }

    private static func emotes(fromDefinition definition: Substring) -> [Emote] {
        let parts = definition.split(separator: ":")
        guard parts.count == 2, let emoteID = parts.first, let emoteRangesString = parts.last else { return [] }
        let emoteRanges = emoteRangesString.split(separator: ",").compactMap { emoteRangeString -> ClosedRange<Int>? in
            let rangeIndexStrings = emoteRangeString.split(separator: "-")
            guard rangeIndexStrings.count == 2,
                  let rangeStartIndexString = rangeIndexStrings.first,
                  let rangeEndIndexString = rangeIndexStrings.last,
                  let rangeStartIndex = Int(rangeStartIndexString),
                  let rangeEndIndex = Int(rangeEndIndexString)
            else { return nil }
            return rangeStartIndex...rangeEndIndex
        }
        return emoteRanges.map { Emote(identifier: String(emoteID), range: $0) }
    }
}

enum EmoteError: Error {
    case invalidImageURL
}
