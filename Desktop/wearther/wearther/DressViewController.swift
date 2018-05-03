//
//  DressViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/1/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class DressViewController: UIViewController {
    
    @IBOutlet weak var imageCollection: UICollectionView!
    var customLayout:CustomImageFlowLayout!
    var images = [Pic]()
    var ref:DatabaseReference!
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        loadDB()
        
        customLayout = CustomImageFlowLayout()
        self.imageCollection.collectionViewLayout = customLayout
    }
    
    func loadDB(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(userID!).child("dresses").observe(DataEventType.value) { (snapshot) in
            var newImages = [Pic]()
            
            for picSnapshot in snapshot.children {
                print(picSnapshot)
                let picObject = Pic(snapshot: picSnapshot as! DataSnapshot)
                newImages.append(picObject)
            }
            self.images = newImages
            self.imageCollection.reloadData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
