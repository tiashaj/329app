//
//  EditProfileViewController.swift
//  wearther
//
//  Created by Kevin Zhang on 4/12/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import CoreData
import FirebaseDatabase

protocol EditProfileProtocolDelegate {
    func somethingHappened()
}

class EditProfileViewController: UIViewController {

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
    
    var delegate: EditProfileProtocolDelegate?
    
    //press save button
    @IBAction func saveButton(_ sender: Any) {
        let name = NameTextField.text
        let email = EmailTextField.text

        //checks for empty text fields and creates alert message
        if (NameTextField.text?.isEmpty)! || (EmailTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "A text field is left empty", message: "You must enter a value for all fields.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            
            self.present(alert, animated: true)
        }
            
        else{
            self.saveProfile(name: (name)!, email: (email)!)
        }
    }
    
    //add profile code
    func saveProfile( name: String, email: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity =  NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        
        let profile = NSManagedObject(entity: entity!, insertInto:managedContext)
        
        // Set the attribute values
        profile.setValue(name, forKey: "name")
        profile.setValue(email, forKey: "email")

        
        // Commit the changes.
        do {
            try managedContext.save()
        } catch {
            // what to do if an error occurs?
            let nserror = error as NSError
            NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
            abort()
        }
        
        // Add the new entity to our array of managed objects
        profiles.append(profile)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile Information"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ProfileViewController{
            if (NameTextField.text?.isEmpty)! || (EmailTextField.text?.isEmpty)! {
                //do nothing
            }
            else{
                //destinationVC.retrievedName = NameTextField.text!
                //destinationVC.retrievedEmail = EmailTextField.text!

            }
            //destinationVC.retrievedName = (profiles.value(forKey: "name") as? String)!
            //destinationVC.retrievedEmail = (profiles.value(forKey: "email") as? String)!
        }
    }

}
