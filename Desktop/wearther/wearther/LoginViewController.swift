//
//  LoginViewController.swift
//  wearther
//
//  Created by Amy Fang on 3/22/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        password.isSecureTextEntry = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func login(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "email = %@", "" + email.text!)
        
        let results:NSArray = try! managedContext.fetch(request) as NSArray
        
        if(results.count >= 1){
            let res = results[0] as! NSManagedObject
            email.text = res.value(forKey: "email") as? String
            password.text = res.value(forKey: "password") as? String
            
            errorMessage.text = ""
        }
        else{
            errorMessage.text = "Invalid username and password"
        }
    }
   /*
    func checkForEmailAndPasswordMatch (email:String, password:String) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
    }
    */
    @IBAction func segueToRegister(_ sender: Any) {
        self.performSegue(withIdentifier: "register", sender: sender)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
