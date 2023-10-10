//
//  Logger.swift
//  MAFoundation
//
//  Created by Dan Gorb on 10.10.2023.
//

//

import Foundation

public struct Logger {
    public enum LogType: String {
        case debug
        case info
        case warning
        case error

        var mark: String {
            switch self {
            case .debug:
                return "🟢"
            case .info:
                return "🔵"
            case .warning:
                return "🟠"
            case .error:
                return "🔴"
            }
        }
    }

    private init() {}
}

private extension Logger {
    static var isLogAllowed: Bool {
        return isDebug
    }

    static func fileName(from file: String) -> String {
        return URL(fileURLWithPath: file).deletingPathExtension().lastPathComponent
    }

    static func performLog(_ subject: Any, type: LogType, file: String, line: UInt, function: String) {
        guard isLogAllowed else {
            return
        }

        let fileName = self.fileName(from: file)
        let logString = "\(type.mark) \(type.rawValue.uppercased()) \(fileName).\(function):\(line) - \(subject)"
        print(logString)
    }
}

public extension Logger {
    static func debug(_ subject: Any, file: String = #fileID, line: UInt = #line, function: String = #function) {
        performLog(subject, type: .debug, file: file, line: line, function: function)
    }

    static func info(_ subject: Any, file: String = #fileID, line: UInt = #line, function: String = #function) {
        performLog(subject, type: .info, file: file, line: line, function: function)
    }

    static func warning(_ subject: Any, file: String = #fileID, line: UInt = #line, function: String = #function) {
        performLog(subject, type: .warning, file: file, line: line, function: function)
    }

    static func error(_ subject: Any, file: String = #fileID, line: UInt = #line, function: String = #function) {
        performLog(subject, type: .error, file: file, line: line, function: function)
    }
}
