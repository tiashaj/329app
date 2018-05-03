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
    
    var backgroundColor:UIColor?
    
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
    /**
    @IBAction func darkButton(_ sender: UIButton) {
        Theme.darkTheme()
        self.loadView()
    }
    
    @IBAction func lightButton(_ sender: UIButton) {
        Theme.defaultTheme()
        self.loadView()
    }
    **/
    
    @IBAction func onRed(_ sender: Any) {
        view.backgroundColor = UIColor(red: 1.0, green: 0.8, blue: 0.8, alpha: 1.0)
        self.backgroundColor = view.backgroundColor
    }
    
    @IBAction func onBlue(_ sender: Any) {
        view.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 1.0, alpha: 1.0)
        
    }
    
    @IBAction func onYellow(_ sender: Any) {
        view.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 0.8, alpha: 1.0)
       
    }
    
    @IBAction func onGray(_ sender: Any) {
        view.backgroundColor = UIColor.lightGray
        
    }
 
    
    @IBAction func onXOut(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
    
    var notificationGranted = false
    
    
    @IBAction func addNotification(_ sender: Any) {
        if notificationGranted{
            repeatNotification()
        }else{
            print("notification not granted")
        }
    }
    
    @IBAction func notifyNow(_ sender: Any) {
        
        let content = UNMutableNotificationContent()
        content.title = "Your outfit is ready!"
        content.subtitle = "Wearther has generated an outfit for you"
        content.body = "Navigate to your Profile to see your outfit for today"
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
