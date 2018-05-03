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
    var userTemp:Int? = 75
    var weatherTemp:Int?
    var finalOutfit = [String:String]()
    
    var segueTemp:Int = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weatherTemp = 35
        print(segueTemp)
        userTemp = segueTemp
        ref = Database.database().reference()
        ref.child("Users").child(self.userID!).observe(DataEventType.value) { (snapshot) in
            let value = snapshot.value as? NSDictionary
            self.userTemp = value?["temperature"] as? Int
            print(self.userID!)
            print(self.userTemp ?? 85)
        }
    }

    @IBAction func btnGenerateOutfit(_ sender: Any) {
        
        // determines outfits based on weather and user's temperature preferences
        if(weatherTemp! >= userTemp!){
            let outfit1 = ["top": "tshirt", "bottom": "shorts", "outerwear": ""] // Option 1: tshirt + shorts
            let outfit2 = ["top": "dress", "bottom": "", "outerwear": ""]        // Option 2: dress
            
            let lstOfOutfits = [outfit1, outfit2]
            self.finalOutfit = lstOfOutfits.randomItem()!
        }
        else if(weatherTemp! < userTemp! && weatherTemp! >= (userTemp! - 10)){
            let outfit1 = ["top": "tshirt", "bottom": "pants", "outerwear": ""]       // Option 1: tshirt + pants
            let outfit2 = ["top": "longsleeve", "bottom": "pants", "outerwear": ""]   // Option 2: sweater + pants
            let outfit3 = ["top": "longsleeve", "bottom": "dress", "outerwear": ""]        // Option 3: sweater + dress
            
            let lstOfOutfits = [outfit1, outfit2, outfit3]
            self.finalOutfit = lstOfOutfits.randomItem()!
        }
        else if(weatherTemp! < (userTemp! - 10) && weatherTemp! >= (userTemp! - 20)){
            self.finalOutfit = ["top": "longsleeve", "bottom": "pants", "outerwear": ""]  // Only option: sweater + pants
        }
        else {
            self.finalOutfit = ["top": "longsleeve", "bottom": "pants", "outerwear": "coat"]  // Only option: sweater + pants
        }
        
        // Display outfit
        if let top = self.finalOutfit["top"] {
            self.topsImage.image = UIImage(named: top)
        }
        if let bottom = self.finalOutfit["bottom"] {
            self.bottomsImage.image = UIImage(named: bottom)
        }
        if let outerwear = self.finalOutfit["outerwear"] {
            self.outerwearImage.image = UIImage(named: outerwear)
        }

    }
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

