//
//  PerseusLogger.swift
//  PerseusRealDeal
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//  All rights reserved.
//
//
//  MIT License
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7531 PerseusRealDeal
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
//  The above copyright notices and this permission notice shall be included in all
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

// DESC: USE LOGGER LIKE A VARIABLE ANYWHERE YOU WANT
//
// By default logger is turned on in DEBUG, but it's off in RELEASE.
//
// log.message("[\(type(of: self))].\(#function)")
//

/* To disable debug messaging of the module use the following statements in the start point.

 import class OpenWeatherFreeClient.PerseusLogger
 typealias FreeClientLogger = OpenWeatherFreeClient.PerseusLogger

 FreeClientLogger.turned = .off

 */

import Foundation

// swiftlint:disable type_name
typealias log = PerseusLogger
// swiftlint:enable type_name

public class PerseusLogger {

    public enum Status {
        case on
        case off
    }

    public enum Level: Int, CustomStringConvertible {

        public var description: String {
            switch self {
            case .info:
                return "INFO"
            case .debug:
                return "DEBUG"
            case .error:
                return "ERROR"
            }
        }

        case info  = 3
        case debug = 2 // Default.
        case error = 1
    }

    #if DEBUG
    public static var turned = Status.on
    #else
    public static var turned = Status.off
    #endif

    public static var level = Level.debug
    public static var short = true

    public static func message(_ text: @autoclosure () -> String,
                               _ type: Level = .debug,
                               _ file: StaticString = #file,
                               _ line: UInt = #line) {

        guard turned == .on, type.rawValue <= level.rawValue else { return }

        var message = ""

        if short {
            message = "\(type): \(text())"
        } else {
            let fileName = (file.description as NSString).lastPathComponent
            message = "\(type): \(text()), file: \(fileName), line: \(line)"
        }

        print(message) // DispatchQueue.main.async { print(message) }
    }
}
