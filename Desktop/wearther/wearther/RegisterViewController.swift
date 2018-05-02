//
//  RegisterViewController.swift
//  wearther
//
//  Created by Amy Fang on 3/22/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    var refUsers: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
        confirmPassword.isSecureTextEntry = true
        
        refUsers = Database.database().reference()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func register(_ sender: Any) {
        if email.text!.isEmpty || password.text!.isEmpty || name.text!.isEmpty {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter your name, email, and password", preferredStyle: .alert)
                
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
                
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        else if !isValidPassword(password: password.text!) {
            let alertController = UIAlertController(title: "Error", message: "Please enter a password with at least 8 characters", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        else if !passwordsMatch(password: password.text!, confirmPassword: confirmPassword.text!) {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: { (user, error) in
                if error == nil {
                    print("You have successfully signed up")
                    
                    // add user to Firebase Database
                    let user = ["email": self.email.text!,
                                "password": self.password.text!,
                                "name": self.name.text!]
                    
                    self.refUsers.child("Users").childByAutoId().setValue(user)
                    
                    //Goes to the Home page
                    self.performSegue(withIdentifier: "home", sender: self)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                        
                    let alertWindow = UIWindow(frame: UIScreen.main.bounds)
                    alertWindow.rootViewController = UIViewController()
                    alertWindow.windowLevel = UIWindowLevelAlert
                    alertWindow.makeKeyAndVisible()
                    alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            })
        }
    }
    
    func isValidPassword (password:String) -> Bool {
        return (password.count >= 8)
    }
    
    func passwordsMatch (password:String, confirmPassword:String) -> Bool {
        return (password == confirmPassword)
    }
    
    @IBAction func segueToLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "registerToLogin", sender: sender)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? MyTabBarController {
            destinationVC.user_email = email.text
        }
    }
    */

}
