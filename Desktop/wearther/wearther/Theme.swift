//
//  Theme.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/3/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    
    static var backgroundColor:UIColor?
    
    static public func defaultTheme() {
        self.backgroundColor = UIColor.lightGray
        updateDisplay()
    }
    
    static public func darkTheme() {
        self.backgroundColor = UIColor.darkGray
        updateDisplay()
    }
    
    static public func updateDisplay() {
        let proxyView = UIView.appearance()
        proxyView.backgroundColor = backgroundColor
    }
}
