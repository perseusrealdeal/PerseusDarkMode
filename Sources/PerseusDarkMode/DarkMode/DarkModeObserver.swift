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
    public var action         : ((_ newStyle: AppearanceStyle?)->Void)?
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
        if keyPath == "StyleObservable",
           let style = change?[.newKey]
        {
            action?(AppearanceStyle.init(rawValue: style as! Int))
        }
    }
    
    deinit
    {
        objectToObserve.removeObserver(self, forKeyPath: "StyleObservable")
    }
}
