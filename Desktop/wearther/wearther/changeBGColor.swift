//
//  changeBGColor.swift
//  wearther
//
//  Created by Kevin Zhang on 5/3/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import Foundation
import UIKit

class UIColourScheme
{
    
    func set(for viewController: UIViewController)
    {
        viewController.view.backgroundColor = bgColour
        //UILabel.appearance().defaultFont = bgFont
    }
    
    func changeToLightGray(for viewController: UIViewController)
    {
        bgColour = UIColor.lightGray
        UIColourScheme.instance.set(for: viewController)
    }
    
    func changeToRed(for viewController: UIViewController)
    {
        bgColour = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0)
        UIColourScheme.instance.set(for: viewController)
    }
    
    func changeToBlue(for viewController: UIViewController)
    {
        bgColour = UIColor(red: 0.5, green: 0.8, blue: 1.0, alpha: 1.0)
        UIColourScheme.instance.set(for: viewController)
    }
    
    func changeToYellow(for viewController: UIViewController)
    {
        bgColour = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
        UIColourScheme.instance.set(for: viewController)
    }
    var bgColour = UIColor.lightGray
    
    /*
    func changeToBold(for viewController: UIViewController)
    {
        bgFont = UIFont.systemFont(ofSize: UIFont.Weight.bold.rawValue)
        UIColourScheme.instance.set(for: viewController)
    }
    
    func changeToThin(for viewController: UIViewController)
    {
        //bgFont = UIFont.systemFont(ofSize: UIFont.Weight.thin.rawValue)
        
        UIColourScheme.instance.set(for: viewController)
    }
    
    func changeToNormal(for viewController: UIViewController)
    {
        bgFont = UIFont.systemFont(ofSize: UIFont.Weight.regular.rawValue)
        UIColourScheme.instance.set(for: viewController)
    }
    
    var bgFont = UIFont.systemFont(ofSize: UIFont.Weight.regular.rawValue)
 */

    
    static let instance = UIColourScheme()
}


extension UILabel{
    var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}

/*
struct AppFontName {
    static let regular = "CourierNewPSMT"
    static let bold = "CourierNewPS-BoldMT"
    static let italic = "CourierNewPS-ItalicMT"
}

extension UIFontDescriptor.AttributeName {
    static let nsctFontUIUsage = UIFontDescriptor.AttributeName(rawValue: "NSCTFontUIUsageAttribute")
}

extension UIFont {
    
    @objc class func mySystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.regular, size: size)!
    }
    
    @objc class func myBoldSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.bold, size: size)!
    }
    
    @objc class func myItalicSystemFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: AppFontName.italic, size: size)!
    }
    
    @objc convenience init(myCoder aDecoder: NSCoder) {
        guard
            let fontDescriptor = aDecoder.decodeObject(forKey: "UIFontDescriptor") as? UIFontDescriptor,
            let fontAttribute = fontDescriptor.fontAttributes[.nsctFontUIUsage] as? String else {
                self.init(myCoder: aDecoder)
                return
        }
        var fontName = ""
        switch fontAttribute {
        case "CTFontRegularUsage":
            fontName = AppFontName.regular
        case "CTFontEmphasizedUsage", "CTFontBoldUsage":
            fontName = AppFontName.bold
        case "CTFontObliqueUsage":
            fontName = AppFontName.italic
        default:
            fontName = AppFontName.regular
        }
        self.init(name: fontName, size: fontDescriptor.pointSize)!
    }
    
    class func overrideInitialize() {
        guard self == UIFont.self else { return }
        
        if let systemFontMethod = class_getClassMethod(self, #selector(systemFont(ofSize:))),
            let mySystemFontMethod = class_getClassMethod(self, #selector(mySystemFont(ofSize:))) {
            method_exchangeImplementations(systemFontMethod, mySystemFontMethod)
        }
        
        if let boldSystemFontMethod = class_getClassMethod(self, #selector(boldSystemFont(ofSize:))),
            let myBoldSystemFontMethod = class_getClassMethod(self, #selector(myBoldSystemFont(ofSize:))) {
            method_exchangeImplementations(boldSystemFontMethod, myBoldSystemFontMethod)
        }
        
        if let italicSystemFontMethod = class_getClassMethod(self, #selector(italicSystemFont(ofSize:))),
            let myItalicSystemFontMethod = class_getClassMethod(self, #selector(myItalicSystemFont(ofSize:))) {
            method_exchangeImplementations(italicSystemFontMethod, myItalicSystemFontMethod)
        }
        
        if let initCoderMethod = class_getInstanceMethod(self, #selector(UIFontDescriptor.init(coder:))), // Trick to get over the lack of UIFont.init(coder:))
            let myInitCoderMethod = class_getInstanceMethod(self, #selector(UIFont.init(myCoder:))) {
            method_exchangeImplementations(initCoderMethod, myInitCoderMethod)
        }
    }
}
 */

