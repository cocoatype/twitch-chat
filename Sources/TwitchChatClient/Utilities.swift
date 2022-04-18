#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif

import Foundation

public enum Utilities {
    public static func commandExists(_ command: String) async -> Bool {
        do {
            _ = try await which(command)
            return true
        } catch {
            return false
        }
    }

    public static func which(_ command: String) async throws -> String {
        return try await run(path: "/usr/bin/which", arguments: [command]).trimmingCharacters(in: .whitespacesAndNewlines)
    }

    public static func prompt(_ message: String) -> Bool {
        Utilities.print("\(message) [Y/n] ".colored(.blue))
        guard let response = readLine() else { return false }
        return ["", "y", "Y"].contains(response)
    }

    public static func query(_ message: String) -> String {
        Utilities.print("\(message) ".colored(.blue))
        return readLine() ?? ""
    }

    private static func passwordQuery(_ string: String) -> String? {
        guard let utf8String = (string as NSString).utf8String, let response = getpass(utf8String) else { return nil }
        return NSString(utf8String: response) as String?
    }

    static func print(_ string: String) {
        let stdout = FileHandle.standardOutput
        guard let data = string.data(using: .utf8) else { return }
        stdout.write(data)
        stdout.synchronizeFile()
    }

    public static func run(_ command: String, requiresSudo: Bool = false) async throws -> String {
        var arguments = command.split(separator: " ").map(String.init)

        let userPassword: String?
        if requiresSudo, let password = passwordQuery("\nPassword: ".colored(.yellow)) {
            userPassword = password
            arguments = ["sudo", "--stdin"] + arguments
        } else { userPassword = nil }

        return try await run(path: "/usr/bin/env", arguments: arguments, userPassword: userPassword)
    }

    private static func run(path: String, arguments: [String]? = nil, userPassword: String? = nil) async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            do {
                let inputPipe = Pipe()
                let outputPipe = Pipe()

                let process = Process()
                process.executableURL = URL(fileURLWithPath: path)
                process.arguments = arguments
                process.standardInput = inputPipe
                process.standardError = outputPipe
                process.standardOutput = outputPipe
                try process.run()

                if let userPassword = userPassword, let passwordData = "\(userPassword)\n".data(using: .utf8) {
                    inputPipe.fileHandleForWriting.write(passwordData)
                    inputPipe.fileHandleForWriting.closeFile()
                }

                process.waitUntilExit()

                let outputData = outputPipe.fileHandleForReading.availableData
                let outputString = String(data: outputData, encoding: .utf8) ?? ""

                if process.terminationStatus == 0 {
                    continuation.resume(returning: outputString)
                } else {
                    let error = RunError.exitedAbnormally(code: process.terminationStatus, output: outputString)
                    continuation.resume(throwing: error)
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
}

enum RunError: Error {
    case exitedAbnormally(code: Int32, output: String)
}
