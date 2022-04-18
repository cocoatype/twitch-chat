import Foundation
public enum Color {
    case black, red, green, yellow, blue, magenta, cyan, white

    static let resetSequence = "\u{001b}[0m"

    var escapeSequence: String {
        switch self {
        case .black: return "\u{001b}[30m"
        case .red: return "\u{001b}[31m"
        case .green: return "\u{001b}[32m"
        case .yellow: return "\u{001b}[33m"
        case .blue: return "\u{001b}[34m"
        case .magenta: return "\u{001b}[35m"
        case .cyan: return "\u{001b}[36m"
        case .white: return "\u{001b}[37m"
        }
    }
}

public extension String {
    func colored(_ color: Color) -> String {
        guard ProcessInfo.processInfo.environment["NO_COLOR"] == nil else { return self }
        return "\(color.escapeSequence)\(self)\(Color.resetSequence)"
    }
}
