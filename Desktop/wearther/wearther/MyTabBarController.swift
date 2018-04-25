//
//  MyTabBarController.swift
//  wearther
//
//  Created by Amy Fang on 4/13/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {
    var user_email:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let moc = …
        let usersFetch = NSFetchRequest(entityName: "User")
        
        do {
            let fetchedUsers = try moc.executeFetchRequest(employeesFetch) as! [User]
        } catch {
            fatalError("Failed to fetch users: \(error)")
        
        fetchRequest.predicate = NSPredicate(format: "email == %@", user_email)
        */
        
        /*
        let weather = WeatherGetter()
        weather.getWeather(city: "Austin")
        */
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
