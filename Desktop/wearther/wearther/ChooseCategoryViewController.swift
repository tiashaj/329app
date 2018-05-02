//
//  ChooseCategoryViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/1/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ChooseCategoryViewController: UIViewController {
    var pic:UIImage?
    var url:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func short_sleeved(_ sender: Any) {
    }
    
    @IBAction func long_sleeved(_ sender: Any) {
    }
    
    @IBAction func pants(_ sender: Any) {
    }
    
    @IBAction func shorts(_ sender: Any) {
    }
    
    @IBAction func dresses(_ sender: Any) {
    }
    
    @IBAction func shoes(_ sender: Any) {
    }
    
    func addItem(category: String, url: String) {
        
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
