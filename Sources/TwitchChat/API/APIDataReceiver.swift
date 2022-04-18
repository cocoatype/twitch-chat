import Foundation

final class APIDataReceiver: NSObject, URLSessionWebSocketDelegate {
    init(token: String, name: String, continuation: AsyncThrowingStream<String, Error>.Continuation) {
        self.token = token
        self.name = name
        self.continuation = continuation
    }

    private func readMessage(from task: URLSessionWebSocketTask) {
        Task {
            do {
                let message = try await task.receive()
                switch message {
                case .data(let data):
                    throw APIError.receivedDataMessage(data)
                case .string(let string):
                    for line in string.split(whereSeparator: { $0.isNewline }) {
                        continuation.yield(String(line))
                    }
                @unknown default:
                    throw APIError.receivedUnknownMessage
                }
                readMessage(from: task)
            } catch {
                continuation.finish(throwing: error)
            }
        }
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?) {
        readMessage(from: webSocketTask)
        webSocketTask.send(.string("PASS oauth:\(token)"), completionHandler: { _ in })
        webSocketTask.send(.string("NICK \(name)"), completionHandler: { _ in })
        webSocketTask.send(.string("CAP REQ :twitch.tv/tags"), completionHandler: { _ in })
        webSocketTask.send(.string("JOIN #\(name)"), completionHandler: { _ in })
    }

    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        continuation.finish()
    }

    private let token: String
    private let name: String
    private let continuation: AsyncThrowingStream<String, Error>.Continuation
}
