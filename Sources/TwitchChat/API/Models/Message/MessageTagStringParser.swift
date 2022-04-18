import Foundation

enum MessageTagStringParser {
    static func tags(from string: Substring) -> [String: String] {
        let tagsString = string.removingPrefix("@")
        let tagSpecifiers = tagsString.split(separator: ";")
        let tagPairs = tagSpecifiers.compactMap { Self.tagKeyAndValue(from: $0) }
        return [String: String](tagPairs, uniquingKeysWith: { key, _ in key })
    }

    private static func tagKeyAndValue(from specifier: Substring) -> (String, String)? {
        let parts = specifier.split(separator: "=")
        guard parts.count == 2, let keyPart = parts.first, let valuePart = parts.last  else { return nil }

        // values must not be empty
        guard valuePart.isEmpty == false else { return nil }

        // unescaping value
        var unescapedValue = ""
        let scanner = Scanner(string: String(valuePart))
        while scanner.isAtEnd == false {
            unescapedValue.append(scanner.scanUpToString("\\"))
            _ = scanner.scanString("\\")

            if let escapedCharacter = scanner.scanCharacter() {
                switch escapedCharacter {
                case ":": unescapedValue.append(";")
                case "s": unescapedValue.append(" ")
                case "r": unescapedValue.append("\r")
                case "n": unescapedValue.append("\n")
                default: unescapedValue.append(escapedCharacter)
                }
            }
        }

        return (String(keyPart), unescapedValue)
    }
}
