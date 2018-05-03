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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func short_sleeved(_ sender: Any) {
        addItem(category: "short_sleeves")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func long_sleeved(_ sender: Any) {
        addItem(category: "long_sleeves")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pants(_ sender: Any) {
        addItem(category: "pants")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shorts(_ sender: Any) {
        addItem(category: "shorts")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dresses(_ sender: Any) {
        addItem(category: "dresses")
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shoes(_ sender: Any) {
        addItem(category: "shoes")
        dismiss(animated: true, completion: nil)
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
                    self.ref.child("Users").child(userID!).child(category).child(imageName).setValue(profileImageURL)
                }
            })
        }
    }
}
