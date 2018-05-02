//
//  DigClosetHomeViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/1/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit

class DigClosetHomeViewController: UIViewController {
    
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
    
    @IBAction func shoes(_ sender: Any) {
        performSegue(withIdentifier: "toShoes", sender: self)
    }

    @IBAction func btnSegueAddItem(_ sender: Any) {
        performSegue(withIdentifier: "toAddItem", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
