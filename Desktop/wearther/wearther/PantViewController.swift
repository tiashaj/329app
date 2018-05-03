//
//  PantViewController.swift
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

class PantViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var imageCollection: UICollectionView!
    var customLayout:CustomImageFlowLayout!
    var images = [Pic]()
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        loadDB()
        
        customLayout = CustomImageFlowLayout()
        self.imageCollection.collectionViewLayout = customLayout
    }
    
    func loadDB(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(userID!).child("pants").observe(DataEventType.value) { (snapshot) in
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
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for:indexPath) as! PicsCollectionViewCell
        let image = images[indexPath.row]
        let storageRef = Storage.storage().reference(forURL: image.url!)
        storageRef.getData(maxSize: 3 * 1024 * 1024, completion: { (data, error) in
            cell.imageView.image = UIImage(data:data!)
        })
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
