 import UIKit
 import UserNotifications
 
 class NotificationViewController: UIViewController {
    
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
