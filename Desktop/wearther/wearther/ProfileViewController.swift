//
//  ProfileViewController.swift
//  wearther
//
//  Created by Kevin Zhang on 4/12/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
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
        var imageURL:String?
        
        ref.child("Users").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            imageURL = value?["profileImageURL"] as? String
        })
        let alertController = UIAlertController(title: "Edit", message: "Give new values to update user", preferredStyle: .alert)
            
        let updateAction = UIAlertAction(title: "Update", style: .default){(_) in
            let name = alertController.textFields?[0].text
            self.updateUser(id: userID!, name: name!, imageURL: imageURL!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
        alertController.addTextField{(textField) in
            textField.text = name
        }
            
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        let alertWindow = UIWindow(frame: UIScreen.main.bounds)
        alertWindow.rootViewController = UIViewController()
        alertWindow.windowLevel = UIWindowLevelAlert
        alertWindow.makeKeyAndVisible()
        alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func updateUser(id: String, name: String, imageURL: String){
        let user = [
            "email": self.EmailLabel.text!,
            "name": name,
            "profileImageURL": imageURL]
        
        ref.child("Users").child(id).setValue(user)
        
        self.NameLabel.text = name
        print("User updated")
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
