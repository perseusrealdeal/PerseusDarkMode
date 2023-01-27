//
//  MockNotificationCenter.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

#if os(iOS)
public typealias Responder = UIResponder
#elseif os(macOS)
public typealias Responder = NSResponder
#endif

import XCTest
@testable import PerseusDarkMode

class MockNotificationCenter: NotificationCenterProtocol {

    // MARK: - addObserver

    var registerCallCount = 0

    var registerArgs_observers: [Any] = []
    var registerArgs_selectors: [Selector] = []

    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any?) {
        // guard let observer = observer as? AnyObject else { return }

        registerCallCount += 1

        registerArgs_observers.append(observer)
        registerArgs_selectors.append(aSelector)
    }

    func verifyRegisterObserver(observer: AnyObject,
                                selector: Selector,
                                file: StaticString = #file,
                                line: UInt = #line) {
        guard registerWasCalledOnce(file: file, line: line) else { return }

        XCTAssertTrue(registerArgs_observers.first! as AnyObject === observer,
                      "observer", file: file, line: line)

        XCTAssertEqual(registerArgs_selectors.first, selector,
                       "selector", file: file, line: line)
    }

    private func registerWasCalledOnce(file: StaticString = #file,
                                       line: UInt = #line) -> Bool {
        return
            verifyMethodCalledOnce(
                methodName: "register",
                callCount: registerCallCount,
                describeArguments: "name: \(registerArgs_selectors)",
                file: file,
                line: line)
    }

    // MARK: - post

    var postCallCount = 0
    var postrgs_names: [String] = []

    func post(name aName: NSNotification.Name, object anObject: Any?) {
        postCallCount += 1
        postrgs_names.append(aName.rawValue)
    }

    func verifyPost(name: NSNotification.Name,
                    file: StaticString = #file,
                    line: UInt = #line) {
        guard postWasCalledOnce(file: file, line: line) else { return }

        XCTAssertTrue(postrgs_names.first! == name.rawValue, "name", file: file, line: line)
    }

    private func postWasCalledOnce(file: StaticString = #file, line: UInt = #line) -> Bool {
        return
            verifyMethodCalledOnce(
                methodName: "post",
                callCount: postCallCount,
                describeArguments: "name: \(postrgs_names)",
                file: file,
                line: line)
    }
}

private func verifyMethodCalledOnce(methodName: String, callCount: Int,
                                    describeArguments: @autoclosure () -> String,
                                    file: StaticString = #file,
                                    line: UInt = #line) -> Bool {
    if callCount == 0 {
        XCTFail("Wanted but not invoked: \(methodName)", file: file, line: line)
        return false
    }

    if callCount > 1 {
        XCTFail("Wanted 1 time but was called \(callCount) times. " +
                    "\(methodName) with \(describeArguments())", file: file, line: line)
        return false
    }

    return true
}
