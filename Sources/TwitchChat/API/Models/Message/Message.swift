import Foundation

struct Message {
    let tags: [String: String]
    let sourceString: String?
    let command: Command
    let parameters: [String]

    init(string: String) throws {
        var parts = string.split(separator: " ")

        if let tagsPart = parts.first, tagsPart.hasPrefix("@") {
            tags = MessageTagStringParser.tags(from: tagsPart)
            parts.removeFirst()
        } else { tags = [:] }

        if let sourcePart = parts.first, sourcePart.hasPrefix(":") {
            sourceString = String(sourcePart.removingPrefix(":"))
            parts.removeFirst()
        } else { sourceString = nil }

        guard let commandPart = parts.first else { throw MessageError.missingCommand(string) }
        let commandString = String(commandPart)
        guard let command = Command(rawValue: commandString) else { throw MessageError.invalidCommand(commandString) }
        self.command = command
        parts.removeFirst()

        parameters = Self.parameters(from: parts)
    }

    private static func parameters(from parts: [Substring]) -> [String] {
        var parameters = [String]()
        for index in (parts.startIndex..<parts.endIndex) {
            let part = parts[index]
            guard part.hasPrefix(":") else {
                parameters.append(String(part))
                continue
            }

            let finalPart = parts.suffix(from: index).joined(separator: " ").removingPrefix(":")
            return parameters + [String(finalPart)]
        }

        return parameters
    }
}
