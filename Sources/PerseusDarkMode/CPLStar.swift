//
//  CPLStar.swift
//  Version: 1.5.0
//
//  Standalone ConsolePerseusLogger.
//
//
//  For iOS and macOS only. Use Stars to adopt for the specifics you need.
//
//  DESC: USE LOGGER LIKE A VARIABLE ANYWHERE YOU WANT.
//
//  [TYPE] [DATE] [TIME] [PID:TID] message, file: #, line: #
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
public typealias log = PerseusLogger // In SPM package should be not public except TheOne.
// swiftlint:enable type_name

public typealias ConsoleObject = (subsystem: String, category: String)
public typealias LocalTime = (date: String, time: String)
public typealias PIDandTID = (pid: String, tid: String) // PID and Thread ID.

public typealias MessageDelegate = (
    (String, PerseusLogger.Level, LocalTime, PIDandTID) -> Void
)

public class PerseusLogger {

    // MARK: - Constants

    private static let SUBSYSTEM = "Perseus"
    private static let CATEGORY = "Lover"

    // MARK: - Specifics

    public enum Status: String, Decodable {
        case on
        case off
    }

    public enum Output: String, Decodable {
        case standard // In Use: Swift.print("").
        case consoleapp
        case custom // In Use: customActionOnMessage?(_:_:_:_:).
    }

    public enum Level: Int, CustomStringConvertible, Decodable {

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

    public enum TimeMultiply: String, Decodable {
        // case millisecond // -3.
        // case microsecond // -6.
        case nanosecond  // -9.
    }

    public enum TIDNumber: String, Decodable {
        case hexadecimal
        case decimal
    }

    public enum MessageFormat: String, Decodable {

        case short

// marks true, time false, owner false, directives false
// [DEBUG] message

// marks true, time true, owner false, directives false
// [DEBUG] [2025-04-17] [20:31:53:630594968] message

// marks true, time false, owner false, directives true
// [DEBUG] message, file: File.swift, line: 29

// marks true, time false, owner true, directives true
// [DEBUG] [6317:0x2519d] message, file: File.swift, line: 29

// marks true, time true, owner true, directives true
// [DEBUG] [2025-04-17] [20:31:53:630918979] [6317:0x2519d] message, file: File.swift, line: 29

// marks false, time false, owner false, directives true
// message, file: File.swift, line: 29

// marks false, time false, owner true, directives true
// [6317:0x2519d] message, file: File.swift, line: 29

// marks false, time false, owner true, directives false
// [6317:0x2519d] message

// marks false, time false, owner false, directives false
// message

        case full
// [DEBUG] [2025-04-17] [20:31:53:630918979] [6317:0x2519d] message, file: File.swift, line: 29

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
    public static var tidnumber = TIDNumber.hexadecimal

    public static var format = MessageFormat.short

    public static var marks = true // Controls tags [TYPE] [DATE] [TIME].
    public static var time = false // + [DATE] [TIME] to message. Depends on format and marks.
    public static var owner = false // + [PID:TID] to message. Depends on format.
    public static var directives = false // + File# and Line# to message. Depends on format.

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

    public static var pidAndTid: PIDandTID {
        return getPIDandTID()
    }

    // MARK: - Internals

    @available(iOS 14.0, macOS 11.0, *)
    private(set) static var consoleLogger: Logger?
    private(set) static var consoleOSLog: OSLog?

    // MARK: - Contract

    public static func loadConfig(_ profile: ProfileCPL) -> Bool {
        if let data = profile.json.data(using: .utf8) {
            if let jsonConfig = decodeJsonProfile(data) {
                reloadOptions(jsonConfig)
                return true
            }
            log.message("Failed to decode CPL json config data!", .error)
            return false
        }
        log.message("Failed to load CPL config data!", .error)
        return false
    }

    public static func loadConfig(_ json: URL) -> Bool {
        if FileManager.default.fileExists(atPath: json.relativePath) {
            if let data = try? Data(contentsOf: json) {
                if let jsonConfig = decodeJsonProfile(data) {
                    reloadOptions(jsonConfig)
                    return true
                }
                log.message("Failed to decode CPL json config data!", .error)
                return false
            }
            log.message("Failed to load CPL config data!", .error)
            return false
        }
        log.message("CPL config file doesn't exist!", .error)
        return false
    }

    public static func message(_ text: @autoclosure () -> String,
                               _ type: Level = .debug,
                               _ oput: Output = PerseusLogger.output,
                               _ file: StaticString = #file,
                               _ line: UInt = #line) {

        guard turned == .on, type.rawValue <= level.rawValue else { return }

        var message = ""

        // Path.

        let withDirectives = (format == .full) ? true : directives && (format != .textonly)

        if withDirectives {
            let fileName = (file.description as NSString).lastPathComponent
            message = "\(text()), file: \(fileName), line: \(line)"
        } else {
            message = "\(text())"
        }

        // PID and TID.

        let withOwnerId = (format == .full) ? true : owner && (format != .textonly)
        let idtuple = getPIDandTID()

        if withOwnerId {
            message = "[\(idtuple.pid):\(idtuple.tid)] \(message)"
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
            customActionOnMessage?(message, type, localTime, idtuple)
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

                let logger = consoleLogger ?? Logger(subsystem: SUBSYSTEM, category: CATEGORY)

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

            let consoleLog = consoleOSLog ?? OSLog(subsystem: SUBSYSTEM, category: CATEGORY)

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

    private static func getLocalTime() -> LocalTime {

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

    private static func getPIDandTID() -> PIDandTID {

        var tid: UInt64 = 0
        pthread_threadid_np(nil, &tid)

        return (pid: "\(ProcessInfo.processInfo.processIdentifier)",
                tid: "\(tidnumber == .hexadecimal ? tid.hex : tid.description)")
    }

    private static func decodeJsonProfile(_ data: Data) -> JsonOptionsCPL? {
        if let json = try? JSONDecoder().decode(JsonOptionsCPL.self, from: data) {
            return json
        }
        return nil
    }

    private static func reloadOptions(_ newValue: JsonOptionsCPL) {
        logObject = (newValue.subsystem, newValue.category)
        // turned = newValue.turned // Ignored, only manually!
        level = newValue.level
        output = newValue.output
        subsecond = newValue.subsecond
        tidnumber = newValue.tidnumber
        format = newValue.format
        marks = newValue.marks
        time = newValue.time
        owner = newValue.owner
        directives = newValue.directives
#if targetEnvironment(simulator)
        debugIsInfo = newValue.debugIsInfo
#endif
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

private extension UInt64 {
    var hex: String {
        return "0x\(String(format: "%02x", self))"
    }
}

// MARK: - Configuration Profiles

private struct JsonOptionsCPL: CustomStringConvertible, Decodable {
    let subsystem: String
    let category: String
    let turned: PerseusLogger.Status
    let level: PerseusLogger.Level
    let output: PerseusLogger.Output
    let subsecond: PerseusLogger.TimeMultiply
    let tidnumber: PerseusLogger.TIDNumber
    let format: PerseusLogger.MessageFormat
    let marks: Bool
    let time: Bool
    let owner: Bool
    let directives: Bool
    let debugIsInfo: Bool

    public var description: String {
        return
"""
\nCPL Configuration Profile values\n
subsystem   : \(subsystem)
category    : \(category)
turned      : \(turned)
level       : \(level)
output      : \(output)
subsecond   : \(subsecond)
tidnumber   : \(tidnumber)
format      : \(format)
marks       : \(marks)
time        : \(time)
owner       : \(owner)
directives  : \(directives)
debugIsInfo : \(debugIsInfo)
\n
"""
    }
}

public enum ProfileCPL: String {

    case debugRoutine
    case debugConcurrency
    case defaultDebug

    public var json: String {
        switch self {
        case .debugRoutine:
            return debugRoutineProfile
        case .debugConcurrency:
            return debugConcurrencyProfile
        case .defaultDebug:
            return defaultDebugProfile
        }
    }
}

private let debugRoutineProfile =
"""
{
    "subsystem"   : "Perseus",
    "category"    : "Lover",
    "turned"      : "on",
    "level"       : 5,
    "output"      : "standard",
    "subsecond"   : "nanosecond",
    "tidnumber"   : "hexadecimal",
    "format"      : "short",
    "marks"       : true,
    "time"        : true,
    "owner"       : false,
    "directives"  : false,
    "debugIsInfo" : true
}
"""

private let debugConcurrencyProfile =
"""
{
    "subsystem"   : "Perseus",
    "category"    : "Lover",
    "turned"      : "on",
    "level"       : 5,
    "output"      : "standard",
    "subsecond"   : "nanosecond",
    "tidnumber"   : "hexadecimal",
    "format"      : "short",
    "marks"       : false,
    "time"        : false,
    "owner"       : true,
    "directives"  : false,
    "debugIsInfo" : true
}
"""

private let defaultDebugProfile =
"""
{
    "subsystem"   : "Perseus",
    "category"    : "Lover",
    "turned"      : "on",
    "level"       : 5,
    "output"      : "standard",
    "subsecond"   : "nanosecond",
    "tidnumber"   : "hexadecimal",
    "format"      : "short",
    "marks"       : true,
    "time"        : false,
    "owner"       : false,
    "directives"  : false,
    "debugIsInfo" : true
}
"""
