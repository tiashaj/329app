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
    var ref: DatabaseReference!
    var pic:UIImage?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIColourScheme.instance.set(for:self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func short_sleeved(_ sender: Any) {
        addItem(category: "short_sleeves")
        self.performSegue(withIdentifier: "backToCloset", sender: self)
    }
    
    @IBAction func long_sleeved(_ sender: Any) {
        addItem(category: "long_sleeves")
        self.performSegue(withIdentifier: "backToCloset", sender: self)
    }
    
    @IBAction func pants(_ sender: Any) {
        addItem(category: "pants")
        self.performSegue(withIdentifier: "backToCloset", sender: self)
    }
    
    @IBAction func shorts(_ sender: Any) {
        addItem(category: "shorts")
        self.performSegue(withIdentifier: "backToCloset", sender: self)
    }
    
    @IBAction func dresses(_ sender: Any) {
        addItem(category: "dresses")
        self.performSegue(withIdentifier: "backToCloset", sender: self)
    }
    
    @IBAction func outer_wear(_ sender: Any) {
        addItem(category: "outer_wear")
        self.performSegue(withIdentifier: "backToCloset", sender: self)
    }
    
    func addItem(category: String) {
        let userID = Auth.auth().currentUser?.uid
        
        let imageName = UUID().uuidString
        let storageRef = Storage.storage().reference().child("digital_closet").child("\(imageName).png")
        
        if let uploadData = UIImagePNGRepresentation(self.pic!){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if let error = error {
                    print(error)
                    return
                }
                
                if let profileImageURL = metadata?.downloadURL()?.absoluteString {
                    self.ref.child("Users").child(userID!).child(category).child(imageName).child("url").setValue(profileImageURL)
                }
            })
        }
    }
}
