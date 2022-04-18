import Foundation
import TwitchChat
import UserNotifications

Task {
    let chat = TwitchChat(token: Secrets.token, name: "cocoatype")
    do {
        for try await message in chat.messages {
            print("\(message.sender.colored(.blue)): \(message.text)")
//            if message.command == .privateMessage,
//               message.parameters.count == 2,
//               let channel = message.parameters.first,
//               let source = message.sourceString,
//               let senderEndIndex = source.firstIndex(of: "!"),
//               let text = message.parameters.last {
//                print(
//                    channel.colored(.magenta) + " " +
//                    String(source.prefix(upTo: senderEndIndex)).colored(.green) + " " +
//                    text)
//                print(String(describing: message.tags))
//            } else {
//                print("Tags: ".colored(.yellow) + String(describing: message.tags))
//                print("Source: ".colored(.yellow) + (message.sourceString ?? "(null)"))
//                print("Message: ".colored(.yellow) + String(describing: message.command))
//                print("Parameters: ".colored(.yellow) + (message.parameters.joined(separator: ", ")))
//            }
        }
    } catch {
        print(String.init(describing: error).colored(.red))
        exit(1)
    }
}

RunLoop.main.run()
