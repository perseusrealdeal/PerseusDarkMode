//
// DarkModeObserver.swift
// PerseusDarkMode
//
// Copyright © 2022 Mikhail Zhigulin. All rights reserved.

#if !os(macOS)
import UIKit
#endif

public class DarkModeObserver: NSObject
{
    public var action         : ((_ newStyle: AppearanceStyle)->Void)?
    public let objectToObserve: DarkMode
    
    public init(_ value: DarkMode)
    {
        objectToObserve = value
        super.init()
        
        objectToObserve.addObserver(self,
                                    forKeyPath: "StyleObservable",
                                    options   : .new,
                                    context   : nil)
    }
    
    public override func observeValue(forKeyPath keyPath: String?,
                                      of object         : Any?,
                                      change            : [NSKeyValueChangeKey : Any]?,
                                      context           : UnsafeMutableRawPointer?)
    {
        guard
            keyPath == "StyleObservable",
            let style = change?[.newKey],
            let styleRawValue = style as? Int,
            let newStyle = AppearanceStyle.init(rawValue: styleRawValue)
        else { return }
        
        action?(newStyle)
    }
    
    deinit
    {
        objectToObserve.removeObserver(self, forKeyPath: "StyleObservable")
    }
}
