import Foundation

final class APIDataSession {
    init(token: String, name: String) {
        let task = URLSession.shared.webSocketTask(with: Self.url)
        self.task = task
        self.lines = AsyncThrowingStream { continuation in
            task.delegate = APIDataReceiver(token: token, name: name, continuation: continuation)
            task.resume()
        }
    }

    let lines: AsyncThrowingStream<String, Error>

    func send(_ string: String) async throws {
        return try await withCheckedThrowingContinuation { continuation in
            task.send(.string(string)) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else { continuation.resume() }
            }
        }
    }

    private static let url: URL = {
        guard let url = URL(string: "wss://irc-ws.chat.twitch.tv") else {
            fatalError("Invalid URL for Twitch chat websockets")
        }
        return url
    }()

    private let task: URLSessionWebSocketTask
}
