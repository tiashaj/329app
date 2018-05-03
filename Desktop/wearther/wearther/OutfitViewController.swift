//
//  OutfitViewController.swift
//  wearther
//
//  Created by Amy Fang on 5/3/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class OutfitViewController: UIViewController {

    @IBOutlet weak var topsImage: UIImageView!
    @IBOutlet weak var bottomsImage: UIImageView!
    @IBOutlet weak var outerwearImage: UIImageView!
    var ref:DatabaseReference!
    let userID = Auth.auth().currentUser?.uid
    var userTemp:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("Users").child(self.userID!).observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.userTemp = value?["temperature"] as? Int
            print(self.userID!)
            print(self.userTemp!)
        }
    }

    @IBAction func btnGenerateOutfit(_ sender: Any) {

//            if(weatherTemp >= userTemp){
//                outfit.text = "short-sleeved shirt and short pants. Dress"
//            }
//            else if(weatherTemp < userTemp && weatherTemp >= (userTemp - 10)){
//                outfit.text = "short-sleeved shirt and long pants. Sweater and long pants. Dress and sweater"
//            }
//            else if(weatherTemp < (userTemp - 10) && weatherTemp >= (userTemp - 20){
//                outfit.text = "sweater and long pants."
//            }
//            else {
//                outfit.text = "thick coat, sweater, and long pants."
//            }

    }
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
