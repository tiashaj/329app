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
    static let instance = UIColourScheme()
}
