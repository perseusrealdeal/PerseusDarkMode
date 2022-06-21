//
//  MockUserDefaults.swift
//  DarkModeTests
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 Mikhail Zhigulin of Novosibirsk.
//  All rights reserved.
//

import XCTest
@testable import PerseusDarkMode

class MockUserDefaults: UserDefaultsProtocol {

    var isValueExists = false

    func valueExists(forKey key: String) -> Bool { isValueExists }

    // MARK: - getValue

    var intergerCallCount = 0
    var intergerArgs_names: [String] = []

    func integer(forKey defaultName: String) -> Int {
        intergerCallCount += 1
        intergerArgs_names.append(defaultName)

        return 0
    }

    func verifyInterger(name: String,
                        file: StaticString = #file,
                        line: UInt = #line) {
        guard intergerWasCalledOnce(file: file, line: line) else { return }

        XCTAssertTrue(intergerArgs_names.first! == name, "interger", file: file, line: line)
    }

    func verifyInterger(file: StaticString = #file,
                        line: UInt = #line) {
        guard intergerWasNotCalled(file: file, line: line) else { return }

        XCTAssertTrue(intergerArgs_names.isEmpty, "interger", file: file, line: line)
    }

    private func intergerWasCalledOnce(file: StaticString = #file, line: UInt = #line) -> Bool {
        verifyMethodCalledOnce(
            methodName: "interger",
            callCount: intergerCallCount,
            describeArguments: "name: \(intergerArgs_names)",
            file: file,
            line: line)
    }

    private func intergerWasNotCalled(file: StaticString = #file, line: UInt = #line) -> Bool {
        verifyMethodNotCalled(
            methodName: "interger",
            callCount: intergerCallCount,
            describeArguments: "name: \(intergerArgs_names)",
            file: file,
            line: line)
    }

    // MARK: - setValue

    var setValueCallCount = 0

    var setValueArgs_values: [Int] = []
    var setValueArgs_keys: [String] = []

    func setValue(_ value: Any?, forKey key: String) {
        guard let value = value as? Int else { return }

        setValueCallCount += 1

        setValueArgs_values.append(value)
        setValueArgs_keys.append(key)
    }

    func verifySetValue(value: Int,
                        key: String,
                        file: StaticString = #file,
                        line: UInt = #line) {
        guard setValueWasCalledOnce(file: file, line: line) else { return }

        XCTAssertTrue(setValueArgs_values.first! == value,
                      "value", file: file, line: line)

        XCTAssertEqual(setValueArgs_keys.first, key,
                       "key", file: file, line: line)
    }

    private func setValueWasCalledOnce(file: StaticString = #file, line: UInt = #line) -> Bool {
        verifyMethodCalledOnce(
            methodName: "setValue",
            callCount: setValueCallCount,
            describeArguments: "keys: \(setValueArgs_keys)",
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

private func verifyMethodNotCalled(methodName: String, callCount: Int,
                                   describeArguments: @autoclosure () -> String,
                                   file: StaticString = #file,
                                   line: UInt = #line) -> Bool {
    if callCount != 0 {
        XCTFail("Don't wanted but invoked: \(methodName)", file: file, line: line)
        return false
    }

    return true
}
