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
        if((temp.text?.isEmpty)!){
            outfit.text = "You must enter a value"
        }
            
        else{
            if let tempInt: Int = Int(temp.text!){
                if (temp.text == "" || temp.text == " "){
                    outfit.text = "enter temp"
                }
                else if(tempInt > 75){
                    outfit.text = "short-sleeved shirt and short pants"
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
