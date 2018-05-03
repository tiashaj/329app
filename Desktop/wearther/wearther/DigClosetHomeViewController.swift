//
//  DigClosetHomeViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/1/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit

class DigClosetHomeViewController: SettingsViewController {
    
    @IBAction func shortShirt(_ sender: Any) {
        performSegue(withIdentifier: "toShortShirt", sender: self)
    }
    
    @IBAction func longShirt(_ sender: Any) {
        performSegue(withIdentifier: "toLongShirt", sender: self)
    }
    
    @IBAction func pant(_ sender: Any) {
        performSegue(withIdentifier: "toPant", sender: self)
    }
    
    @IBAction func shorts(_ sender: Any) {
        performSegue(withIdentifier: "toShorts", sender: self)
    }
    
    @IBAction func dresses(_ sender: Any) {
        performSegue(withIdentifier: "toDresses", sender: self)
    }
    
    @IBAction func outer_wear(_ sender: Any) {
        performSegue(withIdentifier: "toOuterwear", sender: self)
    }

    @IBAction func btnSegueAddItem(_ sender: Any) {
        performSegue(withIdentifier: "toAddItem", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
