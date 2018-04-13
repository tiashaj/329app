//
//  RegisterViewController.swift
//  wearther
//
//  Created by Amy Fang on 3/22/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import CoreData

class RegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func register(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        // Create the entity we want to save
        let entity = NSEntityDescription.entity(forEntityName: "User", in: managedContext)
        let newUser = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        if !(name.text?.isEmpty ?? true) && !(email.text?.isEmpty ?? true) && !(password.text?.isEmpty ?? true) && !(confirmPassword.text?.isEmpty ?? true) {
            if !isValidPassword(password: password.text!) {
                errorMessage.text = "Password needs at least 8 characters"
            }
            else if !(passwordsMatch(password: password.text!, confirmPassword: confirmPassword.text!)) {
                errorMessage.text = "Passwords do not match"
            }
            else {
                newUser.setValue(name.text, forKey: "name")
                newUser.setValue(email.text, forKey: "email")
                newUser.setValue(password.text, forKey: "password")
                
                // Commit changes
                do {
                    try managedContext.save()
                    errorMessage.text = ""
                    print("User saved")
                } catch {
                    // what to do if an error occurs?
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
        }
        else {
            errorMessage.text = "All fields need to be filled"
        }
    }
    
    func isValidPassword (password:String) -> Bool {
        return (password.count >= 8)
    }
    
    func passwordsMatch (password:String, confirmPassword:String) -> Bool {
        return (password == confirmPassword)
    }
    
    @IBAction func segueToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "login", sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            print("something")
        }
    }

}
