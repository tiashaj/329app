//
//  SettingsViewController.swift
//  wearther
//
//  Created by Tiasha Joardar on 5/2/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsViewController: UIViewController {
    
    var notificationGranted = false
    
    @IBAction func onRed(_ sender: Any) {
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0)
    }
    
    @IBAction func onBlue(_ sender: Any) {
        view.backgroundColor = UIColor(red: 0.7, green: 0.8, blue: 1, alpha: 1.0)
    }
    
    @IBAction func onYellow(_ sender: Any) {
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
    }
    
    func repeatNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Get an Outfit!"
        content.body = "Let WearTher generate your outfit for today"
        content.categoryIdentifier = "outfit.reminder.category"
        
        var dateComponents = DateComponents()
        //Every day at 9 AM
        dateComponents.hour = 9
        dateComponents.minute = 00
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
    
    @IBAction func notifyNow(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "Your outfit is ready!"
        content.subtitle = "Wearther has generated an outfit for you"
        content.body = "Navigate to your Profile to see your outfit for today"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
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
