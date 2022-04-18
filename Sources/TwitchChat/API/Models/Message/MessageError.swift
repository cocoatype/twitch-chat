public enum MessageError: Error {
    case invalidCommand(String)
    case missingCommand(String)
}
