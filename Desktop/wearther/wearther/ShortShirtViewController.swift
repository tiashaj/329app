//
//  ShortShirtViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/1/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ShortShirtViewController: UIViewController, UICollectionViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
