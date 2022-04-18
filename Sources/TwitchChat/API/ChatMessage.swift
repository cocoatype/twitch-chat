public struct ChatMessage {
    init?(_ message: Message) {
        guard message.command == .privateMessage,
              message.parameters.count == 2,
              let channel = message.parameters.first,
              let text = message.parameters.last,
              let sender = message.sender
        else { return nil }

        self.channel = channel
        self.text = text
        self.sender = sender
    }

    public let channel: String
    public let sender: String
    public let text: String
}

private extension Message {
    var sender: String? {
        if let displayName = tags["display-name"] {
            return displayName
        } else if let source = sourceString,
                  let senderEndIndex = source.firstIndex(of: "!") {
            return String(source.prefix(upTo: senderEndIndex))
        } else {
            return nil
        }
    }
}
