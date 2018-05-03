//
//  ProfileViewController.swift
//  wearther
//
//  Created by Kevin Zhang on 4/12/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    @IBOutlet weak var TempLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Profile Screen"
        ref = Database.database().reference()
        displayText()
        displayPic()
    }
    
    //external function to fill up text labels
    func displayText() {
        let userID = Auth.auth().currentUser?.uid
        ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String
            let name = value?["name"] as? String
            if let temp = value?["temperature"] as? Int {
                self.TempLabel.text = "\(temp)"
            }
            self.NameLabel.text = name
            self.EmailLabel.text = email
        }, withCancel: nil)
    }
    
    func displayPic(){
        self.profilePic?.contentMode = .scaleAspectFill
        
        let userID = Auth.auth().currentUser?.uid
        
        ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let imageURL = value?["profileImageURL"] as? String
            print(imageURL!)
            let storageRef = Storage.storage().reference(forURL: imageURL!)
            storageRef.getData(maxSize: 2 * 1024 * 1024, completion: { (data, error) in
                self.profilePic?.image = UIImage(data:data!)
                self.profilePic.layer.masksToBounds = false
                self.profilePic.clipsToBounds = true
                self.profilePic.layer.cornerRadius = self.profilePic.frame.size.height / 2
            })
        })
    }
    
    @IBAction func btnEditProfile(_ sender: Any) {
        let userID = Auth.auth().currentUser?.uid
        let name = NameLabel.text
        let temp = TempLabel.text
        
        let alertController = UIAlertController(title: "Edit", message: "Give new values to update user", preferredStyle: .alert)
            
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let name = alertController.textFields?[0].text
            let temp = alertController.textFields?[1].text
            
            if (temp?.isNumeric)! {
                self.ref.child("Users").child(userID!).child("name").setValue(name)
                self.ref.child("Users").child(userID!).child("temperature").setValue(Int(temp!))
                self.NameLabel.text = name
                self.TempLabel.text = temp
            } else {
                let alertController = UIAlertController(title: "Error", message: "Please enter a valid temperature", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                
                let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                alertWindow.rootViewController = UIViewController()
                alertWindow.windowLevel = UIWindowLevelAlert
                alertWindow.makeKeyAndVisible()
                alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        alertController.addTextField{(textField) in
            textField.text = name
        }
        alertController.addTextField{(textField) in
            textField.text = temp
        }
            
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func btnLogOut(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
                present(vc, animated: true, completion: nil)
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
