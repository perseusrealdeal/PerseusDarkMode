//
//  MockNotificationCenter.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 2022.
//
//  Copyright (c) 2022 Mikhail Zhigulin of Novosibirsk.
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

import XCTest
@testable import PerseusDarkMode

class MockNotificationCenter: NotificationCenterProtocol {

    // MARK: - addObserver

    var registerCallCount = 0

#if os(iOS)
    var registerArgs_observers: [UIResponder] = []
#elseif os(macOS)
    var registerArgs_observers: [NSResponder] = []
#endif

    var registerArgs_selectors: [Selector] = []

#if os(iOS)
    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any?) {
        guard let observer = observer as? UIResponder else { return }

        registerCallCount += 1

        registerArgs_observers.append(observer)
        registerArgs_selectors.append(aSelector)
    }

    func verifyRegisterObserver(observer: UIResponder,
                                selector: Selector,
                                file: StaticString = #file,
                                line: UInt = #line) {
        guard registerWasCalledOnce(file: file, line: line) else { return }

        XCTAssertTrue(registerArgs_observers.first! === observer,
                      "observer", file: file, line: line)

        XCTAssertEqual(registerArgs_selectors.first, selector,
                       "selector", file: file, line: line)
    }
#elseif os(macOS)
    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any?) {
        guard let observer = observer as? NSResponder else { return }

        registerCallCount += 1

        registerArgs_observers.append(observer)
        registerArgs_selectors.append(aSelector)
    }

    func verifyRegisterObserver(observer: NSResponder,
                                selector: Selector,
                                file: StaticString = #file,
                                line: UInt = #line) {
        guard registerWasCalledOnce(file: file, line: line) else { return }

        XCTAssertTrue(registerArgs_observers.first! === observer,
                      "observer", file: file, line: line)

        XCTAssertEqual(registerArgs_selectors.first, selector,
                       "selector", file: file, line: line)
    }
#endif

    private func registerWasCalledOnce(file: StaticString = #file, line: UInt = #line) -> Bool {
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
