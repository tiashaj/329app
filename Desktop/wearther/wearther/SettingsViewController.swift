//
//  SettingsViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/2/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBAction func onRed(_ sender: Any) {
        view.backgroundColor = UIColor.red
    }
    
    @IBAction func onBlue(_ sender: Any) {
        view.backgroundColor = UIColor.blue
    }
    
    @IBAction func onYellow(_ sender: Any) {
        view.backgroundColor = UIColor.yellow
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
