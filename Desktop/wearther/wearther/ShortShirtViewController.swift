//
//  ShortShirtViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/2/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

<<<<<<< HEAD
<<<<<<< HEAD
import UIKit
import Firebase
||||||| merged common ancestors
import UIKit
=======

>>>>>>> 2a6ad15229aa1149c5b1e3ab8da374addfed0c73
||||||| merged common ancestors
import UIKit
=======

>>>>>>> 1b63c0d8889a35d0025e4284938219fb36500ae7
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage

class ShortShirtViewController: UIViewController, UICollectionViewDataSource {
<<<<<<< HEAD
    
    @IBOutlet weak var imageCollection: UICollectionView!
    var customLayout:CustomImageFlowLayout!
    var images = [Pic]()
    var ref:DatabaseReference!
||||||| merged common ancestors
    var images = [UIImage]()
<<<<<<< HEAD
    @IBOutlet weak var imageCollection: UICollectionView!
=======
    var images = [UIImage]()
>>>>>>> 2a6ad15229aa1149c5b1e3ab8da374addfed0c73
||||||| merged common ancestors
    @IBOutlet weak var imageCollection: UICollectionView!
=======
>>>>>>> 1b63c0d8889a35d0025e4284938219fb36500ae7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        loadDB()
        
        customLayout = CustomImageFlowLayout()
        self.imageCollection.collectionViewLayout = customLayout
    }
    
<<<<<<< HEAD
    func loadDB(){
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(userID!).child("short_sleeves").observe(DataEventType.value) { (snapshot) in
            var newImages = [Pic]()
            
            for picSnapshot in snapshot.children {
                print(picSnapshot)
                let picObject = Pic(snapshot: picSnapshot as! DataSnapshot)
                newImages.append(picObject)
            }
            self.images = newImages
            self.imageCollection.reloadData()
        }
||||||| merged common ancestors
    func loadImages(){
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        
        self.imageCollection.reloadData()
=======
    func loadImages(){
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        images.append(UIImage(named: "tshirt.png"))
        
        self.imageCollection.reloadData()
>>>>>>> 2a6ad15229aa1149c5b1e3ab8da374addfed0c73
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
        print(image.url)
        let storageRef = Storage.storage().reference(forURL: image.url)
        storageRef.getData(maxSize: 3 * 1024 * 1024, completion: { (data, error) in
            cell.imageView.image = UIImage(data:data!)
        })
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
 

