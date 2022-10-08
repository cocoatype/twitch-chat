import Foundation
import TwitchChat
import UserNotifications

Task {
    let chat = TwitchChat(token: CommandLine.arguments[1], name: "cocoatype")
    do {
        for try await message in chat.messages {
            print("\(message): \(message.text)")
        }
    } catch {
        print(String(describing: error))
        exit(1)
    }
}

RunLoop.main.run()
