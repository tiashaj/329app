//
//  NotificationViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/2/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UIViewController {
    
    func repeatNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Get an Outfit!"
        content.body = "Let WearTher generate your outfit for today"
        content.categoryIdentifier = "outfit.reminder.category"
        
        var dateComponents = DateComponents()
        //Every Monday at 11:30AM
        //dateComponents.hour = 11
        //dateComponents.minute = 30
        //dateComponents.weekday = 2
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "outfit.reminder", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error in pizza reminder: \(error.localizedDescription)")
            }
        }
        print("added notification:\(request.identifier)")
        
    }
    
    
    var notificationGranted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(
        options: [.alert,.sound]){
            (granted, error) in
            self.notificationGranted = granted
            if let error = error {
                print("granted, but Error in notification permission:\(error.localizedDescription)")
            }
        }
    }
    
    @IBAction func addNotification(_ sender: Any) {
        if notificationGranted{
            repeatNotification()
        }else{
            print("notification not granted")
        }
    }
    
    @IBAction func showNotification(_ sender: Any) {
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
