//
//  CPLStar.swift
//  Version: 1.3.0
//
//  Standalone ConsolePerseusLogger.
//
//
//  For iOS and macOS only. Use Stars to adopt for the specifics you need.
//
//  DESC: USE LOGGER LIKE A VARIABLE ANYWHERE YOU WANT.
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  All rights reserved.
//
//
//  MIT License
//
//  Copyright © 7531 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7531 - 7533 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//
// swiftlint:disable file_length
//

import Foundation
import os

// swiftlint:disable type_name
typealias log = PerseusLogger // In SPM package should be not public except TheOne.
// swiftlint:enable type_name

public typealias ConsoleObject = (subsystem: String, category: String)
public typealias LocalTime = (date: String, time: String)

public typealias MessageDelegate = ((String, PerseusLogger.Level, LocalTime) -> Void)

public let CONSOLE_APP_SUBSYSTEM_DEFAULT = "Perseus"
public let CONSOLE_APP_CATEGORY_DEFAULT = "Logger"

public class PerseusLogger {

    // MARK: - Specifics

    public enum Status {
        case on
        case off
    }

    public enum Output {
        case standard // In Use: Swift.print("").
        case consoleapp
        case custom // In Use: customActionOnMessage?(_:_:_:).
    }

    public enum Level: Int, CustomStringConvertible {

        public var description: String {
            switch self {
            case .debug:
                return "DEBUG"
            case .info:
                return "INFO"
            case .notice:
                return "NOTE"
            case .error:
                return "ERROR"
            case .fault:
                return "FAULT"
            }
        }

        public var tag: String {
            switch self {
            case .debug:
                return "[DEBUG]"
            case .info:
                return "[INFO ]"
            case .notice:
                return "[NOTE ]"
            case .error:
                return "[ERROR]"
            case .fault:
                return "[FAULT]"
            }
        }

        case debug  = 5
        case info   = 4
        case notice = 3
        case error  = 2
        case fault  = 1
    }

    public enum TimeMultiply {
        // case millisecond // -3.
        // case microsecond // -6.
        case nanosecond  // -9.
    }

    public enum MessageFormat { // [TYPE] [DATE] [TIME] message, file: #, line: #

        case short
        // marks true, time false, directives false
        // [DEBUG] message

        // marks true, time true, directives false
        // [DEBUG] [2025-04-17] [20:31:53:630594968] message

        // marks true, time false, directives true
        // [DEBUG] message, file: File.swift, line: 29

        // marks true, time true, directives true
        // [DEBUG] [2025-04-17] [20:31:53:630918979] message, file: File.swift, line: 29

        // marks false, directives true
        // message, file: File.swift, line: 29

        // marks false, directives false
        // message

        case full
        // [DEBUG] [2025-04-17] [20:31:53:630918979] message, file: File.swift, line: 29

        case textonly
        // message
    }

    // MARK: - Properties

    public static var customActionOnMessage: MessageDelegate?

#if DEBUG
    public static var turned = Status.on
    public static var level = Level.debug
    public static var output = Output.standard
#else
    public static var turned = Status.off
    public static var level = Level.notice
    public static var output = Output.consoleapp
#endif

    public static var subsecond = TimeMultiply.nanosecond
    public static var format = MessageFormat.short

    public static var marks = true // Controls tags [TYPE] [DATE] [TIME].
    public static var time = false // If also and marks true adds [DATE] [TIME] to message.

    public static var directives = false // File# and Line# in message.

#if targetEnvironment(simulator)
    public static var debugIsInfo = true // Shows DEBUG message as INFO in macOS Console.app.
#endif

    public static var logObject: ConsoleObject? {
        didSet {

            guard let obj = logObject else {

                if #available(iOS 14.0, macOS 11.0, *) {
                    consoleLogger = nil
                }

                consoleOSLog = nil

                return
            }

            if #available(iOS 14.0, macOS 11.0, *) {
                consoleLogger = Logger(subsystem: obj.subsystem, category: obj.category)
            } else {
                consoleOSLog = OSLog(subsystem: obj.subsystem, category: obj.category)
            }
        }
    }

    public static var localTime: LocalTime {
        return getLocalTime()
    }

    // MARK: - Internals

    @available(iOS 14.0, macOS 11.0, *)
    private(set) static var consoleLogger: Logger?
    private(set) static var consoleOSLog: OSLog?

    // MARK: - Contract

    public static func message(_ text: @autoclosure () -> String,
                               _ type: Level = .debug,
                               _ oput: Output = PerseusLogger.output,
                               _ file: StaticString = #file,
                               _ line: UInt = #line) {

        guard turned == .on, type.rawValue <= level.rawValue else { return }

        var message = ""

        // Path.

        let withDirectives = (format == .full) ? true : (directives && (format != .textonly))

        if withDirectives {
            let fileName = (file.description as NSString).lastPathComponent
            message = "\(text()), file: \(fileName), line: \(line)"
        } else {
            message = "\(text())"
        }

        // Time.

        let isTimed = (format == .full) ? true : marks && time && (format != .textonly)
        let localTime = getLocalTime()

        if isTimed {
            message = "[\(localTime.date)] [\(localTime.time)] \(message)"
        }

        // Type.

        let isTyped = (format == .full) ? true : marks && (format != .textonly)
        message = isTyped ? "\(type.tag) \(message)" : message

        // Print.

        if oput == .custom {
            customActionOnMessage?(message, type, localTime)
        } else {
            print(message, type, oput)
        }
    }

    // MARK: - Implementation

    // swiftlint:disable:next cyclomatic_complexity
    private static func print(_ text: String, _ type: Level, _ output: Output) {

        let message = (text: text, type: type)

        if output == .standard {

            Swift.print(message.text) // DispatchQueue.main.async { print(message) }

        } else if output == .consoleapp {

            if #available(iOS 14.0, macOS 11.0, *) {

                let logger = consoleLogger ?? Logger(subsystem: CONSOLE_APP_SUBSYSTEM_DEFAULT,
                                                     category: CONSOLE_APP_CATEGORY_DEFAULT)

                switch message.type {
                case .debug:
#if targetEnvironment(simulator)
                    if debugIsInfo {
                        logger.info("\(message.text, privacy: .public)")
                    } else {
                        logger.debug("\(message.text, privacy: .public)")
                    }
#else
                    logger.debug("\(message.text, privacy: .public)")
#endif
                case .info:
                    logger.info("\(message.text, privacy: .public)")
                case .notice:
                    logger.notice("\(message.text, privacy: .public)")
                case .error:
                    logger.error("\(message.text, privacy: .public)")
                case .fault:
                    logger.fault("\(message.text, privacy: .public)")
                }

                return
            }

            let consoleLog = consoleOSLog ?? OSLog(subsystem: CONSOLE_APP_SUBSYSTEM_DEFAULT,
                                                   category: CONSOLE_APP_CATEGORY_DEFAULT)

            switch message.type {
            case .debug:
#if targetEnvironment(simulator)
                if debugIsInfo {
                    os_log("%{public}@", log: consoleLog, type: .info, message.text)
                } else {
                    os_log("%{public}@", log: consoleLog, type: .debug, message.text)
                }
#else
                os_log("%{public}@", log: consoleLog, type: .debug, message.text)
#endif
            case .info:
                os_log("%{public}@", log: consoleLog, type: .info, message.text)
            case .notice:
                os_log("%{public}@", log: consoleLog, type: .default, message.text)
            case .error:
                os_log("%{public}@", log: consoleLog, type: .error, message.text)
            case .fault:
                os_log("%{public}@", log: consoleLog, type: .fault, message.text)
            }
        }
    }

    private static func getLocalTime() -> (date: String, time: String) {

        guard let timezone = TimeZone(secondsFromGMT: 0) else { return ("TIME", "TIME") }

        var calendar = Calendar.current

        calendar.timeZone = timezone
        calendar.locale = Locale(identifier: "en_US_POSIX")

        let current = Date(timeIntervalSince1970: (Date().timeIntervalSince1970 +
                                                   Double(TimeZone.current.secondsFromGMT())))

        let details: Set<Calendar.Component> =
        [
            .year, .month, .day, .hour, .minute, .second, .nanosecond
        ]

        let components = calendar.dateComponents(details, from: current)

        // Parse date.

        guard
            let year = components.year,
            let month = components.month?.inTime,
            let day = components.day?.inTime else { return ("TIME", "TIME") }

        let date = "\(year)-\(month)-\(day)"

        // Parse time.

        guard
            let hour = components.hour?.inTime, // Always in 24-hour.
            let minute = components.minute?.inTime,
            let second = components.second?.inTime,
            let subsecond = components.nanosecond?.multiply else { return ("TIME", "TIME") }

        let time = "\(hour):\(minute):\(second):\(subsecond)"

        return (date: date, time: time)
    }
}

// MARK: - Helpers

private extension Int {

    var inTime: String {
        guard self >= 0, self <= 9 else { return String(self) }
        return "0\(self)"
    }

    var multiply: String {
        return String(self)
    }
}
