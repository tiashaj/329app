//
//  TemperatureViewController.swift
//  wearther
//
//  Created by Amy Fang on 5/3/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

extension String {
    var isNumeric: Bool {
        guard self.characters.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
}

class TemperatureViewController: UIViewController {
    
    @IBOutlet weak var temperature: UITextField!
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }

    @IBAction func btnSubmit(_ sender: Any) {
        if temperature.text!.isEmpty || !temperature.text!.isNumeric || Int(temperature.text!)! < -20 && Int(temperature.text!)! > 100 {
            let alertController = UIAlertController(title: "Error", message: "Please enter a valid temperature", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            let alertWindow = UIWindow(frame: UIScreen.main.bounds)
            alertWindow.rootViewController = UIViewController()
            alertWindow.windowLevel = UIWindowLevelAlert
            alertWindow.makeKeyAndVisible()
            alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        } else {
            let userID = Auth.auth().currentUser?.uid
            self.ref.child("Users").child(userID!).child("temperature").setValue(Int(temperature.text!))
            
            //Goes to the Home page
            self.performSegue(withIdentifier: "toHome", sender: self)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
