//
//  OutputViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 4/9/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit

class OutputViewController: UIViewController {

    @IBOutlet weak var today: UILabel!
    @IBOutlet weak var temp: UITextField!
    @IBOutlet weak var outfit: UILabel!
    
    
    @IBAction func onClick(_ sender: Any) {
        
        if((temp.text?.isEmpty)! || !(temp.text?.isNumber)!){
            outfit.text = "You must enter a number"
        }
            
        else{
            if let tempInt: Int = Int(temp.text!){
                if (tempInt > 120 || tempInt < -20){
                    outfit.text = "Enter a temperature between -20 and 120"
                }
                else if(tempInt >= 70){
                    outfit.text = "short-sleeved shirt and short pants."
                }
                else if(tempInt < 70 && tempInt >= 60){
                    outfit.text = "short-sleeved shirt and long pants. Bring a sweater!"
                }
                else if(tempInt < 60 && tempInt >= 50){
                    outfit.text = "long-sleeved shirt and long pants. Bring a sweater!"
                }
                else {
                    outfit.text = "thick coat, sweater, and long pants."
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension String  {
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
}
