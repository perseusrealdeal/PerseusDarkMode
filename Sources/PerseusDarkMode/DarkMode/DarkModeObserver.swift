//
//  DarkModeObserver.swift
//  PerseusDarkMode
//
//  Created by Mikhail Zhigulin in 7530.
//
//  Copyright © 7530 - 7533 Mikhail A. Zhigulin of Novosibirsk
//  Copyright © 7533 PerseusRealDeal
//
//  Licensed under the MIT license. See LICENSE file.
//  All rights reserved.
//
// swiftlint:disable block_based_kvo
//

#if canImport(UIKit)
import UIKit
#elseif canImport(Cocoa)
import Cocoa
#endif

/// Responsible for making run the code if the app's appearance style changed.
///
/// It connects to shared Dark Mode instance using appearance service.
/// Also, it takes action every time when the app's appearance style changed.
///
/// The action can be specified with initialization as the passed closue
/// and after initialization by assigning the action property as well.
public class DarkModeObserver: NSObject {
    /// Closure to perform if the app's appearance style changed.
    public var action: ((_ newStyle: AppearanceStyle) -> Void)?

    /// The reference of the object to be obsevered.
    private(set) var objectToObserve = AppearanceService.shared

    /// Initializer by default.
    ///
    /// It creates the instance with no action specified if the app's appearance style changed.
    ///
    /// Then, give it a closure to run the code if the app's appearance style changed.
    public override init() {
        super.init()

        objectToObserve.addObserver(self,
                                    forKeyPath: OBSERVERED_VARIABLE_NAME,
                                    options: .new,
                                    context: nil)
    }

    /// Initializer with parameters.
    ///
    /// Pass a closure to specify the action to be taken if the app's appearance style changed.
    public init(_ action: @escaping ((_ newStyle: AppearanceStyle) -> Void)) {
        super.init()

        self.action = action
        objectToObserve.addObserver(self,
                                    forKeyPath: OBSERVERED_VARIABLE_NAME,
                                    options: .new,
                                    context: nil)
    }

    /// Takes action every time when Style changes happens.
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object: Any?,
                                      change: [NSKeyValueChangeKey: Any]?,
                                      context: UnsafeMutableRawPointer?) {
        guard
            keyPath == OBSERVERED_VARIABLE_NAME,
            let style = change?[.newKey],
            let styleRawValue = style as? Int,
            let newStyle = AppearanceStyle.init(rawValue: styleRawValue)
        else { return }

        action?(newStyle)
    }

    deinit {
        objectToObserve.removeObserver(self, forKeyPath: OBSERVERED_VARIABLE_NAME)
    }
}
