//
//  DisplayViewController.swift
//  wearther
//
//  Created by Kevin Zhang on 4/24/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation

class DisplayViewController: UIViewController,
    WeatherGetterDelegate,
    UITextFieldDelegate,
    CLLocationManagerDelegate
{
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var getCityWeatherButton: UIButton!
    let latitude:Double = 0
    let longitude:Double = 0
    var weather: WeatherGetter!
    var segueTemp:Int = 0
    var locationManager:CLLocationManager!
    var cityString:String = ""
    
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather = WeatherGetter(delegate: self)
        
        // Initialize UI
        // -------------
        cityLabel.text = "simple weather"
        weatherLabel.text = ""
        temperatureLabel.text = ""
        cloudCoverLabel.text = ""
        windLabel.text = ""
        rainLabel.text = ""
        humidityLabel.text = ""
        cityTextField.text = ""
        cityTextField.placeholder = "Enter city name"
        cityTextField.delegate = self
        cityTextField.enablesReturnKeyAutomatically = true
        cityString = readDataFromFile(file: "CityList")

        //getCityWeatherButton.isEnabled = false

        /*
        // For use when the app is open & in the background
        //locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate? = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
            
        }
        */
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Button events
    // ---------------------
    
    /*
    //Location Stuff
    // Print out the location to the console
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            print(location.coordinate)
        }
    }
    
    // If we have been deined access give the user the option to change it
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied) {
            showLocationDisabledPopUp()
        }
    }
    
    // Show the popup to the user if we have been deined access
    func showLocationDisabledPopUp() {
        let alertController = UIAlertController(title: "Background Location Access Disabled",
                                                message: "In order to deliver pizza we need your location",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func updateLocationButton(sender: UIButton) {
        
        
        let geoCoder = CLGeocoder()
        //let location = CLLocation(latitude: 40.730610, longitude:  -73.935242) // <- New York
        let location = CLLocation(latitude: CLLocationDegrees(latitude), longitude:  CLLocationDegrees(longitude))
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, _) -> Void in placemarks?.forEach
            {
                (placemark) in if let city = placemark.locality
                {
                    print(city)
                    
                } // Prints "New York"
            }
        })

    }
 */
    
    //Will crash if you put a non-real city in
    
    @IBAction func getWeatherForCityButtonTapped(sender: Any) {
        guard let text = cityTextField.text, !text.isEmpty else {
            return
        }
        let spaceString:String = cityTextField.text!
        if cityString.lowercased().range(of: spaceString.lowercased()) != nil {
            print("exists")
            //weather.getWeather(city: cityTextField.text!.urlEncoded)
            let percString = spaceString.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
            weather.getWeather(city: percString)
        }
        else
        {
            print("not a real city")
            return
        }
    }
    
    //Location Methods
    
    
    // MARK: -
    
    // MARK: WeatherGetterDelegate methods
    // -----------------------------------
    
    func didGetWeather(weather: Weather) {
        // This method is called asynchronously, which means it won't execute in the main queue.
        // ALl UI code needs to execute in the main queue, which is why we're wrapping the code
        // that updates all the labels in a dispatch_async() call.
        DispatchQueue.main.async() {
            self.cityLabel.text = weather.city
            self.weatherLabel.text = weather.weatherDescription
            self.temperatureLabel.text = "\(Int(round(weather.tempFahrenheit)))°"
            self.cloudCoverLabel.text = "\(weather.cloudCover)%"
            self.windLabel.text = "\(weather.windSpeed) m/s"
            
            if let rain = weather.rainfallInLast3Hours {
                self.rainLabel.text = "\(rain) mm"
            }
            else {
                self.rainLabel.text = "None"
            }
            self.humidityLabel.text = "\(weather.humidity)%"
        }
        
        if let tempInt: Int = Int(round(weather.tempFahrenheit)){
            var outfit:String = ""
            segueTemp = Int(round(weather.tempFahrenheit))
            if (tempInt > 120 || tempInt < -20){
                outfit = "Enter a temperature between -20 and 120"
            }
            else if(tempInt >= 70){
                outfit = "short-sleeved shirt and short pants."
            }
            else if(tempInt < 70 && tempInt >= 60){
                outfit = "short-sleeved shirt and long pants. Bring a sweater!"
            }
            else if(tempInt < 60 && tempInt >= 50){
                outfit = "long-sleeved shirt and long pants. Bring a sweater!"
            }
            else {
                outfit = "thick coat, sweater, and long pants."
            }
            print(outfit)
        }
    }

    //segue function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? OutfitViewController
        {
            destinationVC.segueTemp = segueTemp
        }
    }
 
    
    func didNotGetWeather(error: NSError) {
        // This method is called asynchronously, which means it won't execute in the main queue.
        // ALl UI code needs to execute in the main queue, which is why we're wrapping the call
        // to showSimpleAlert(title:message:) in a dispatch_async() call.
        DispatchQueue.main.async() {
            self.showSimpleAlert(title: "Can't get the weather",
                                 message: "The weather service isn't responding.")
        }
        print("didNotGetWeather error: \(error)")
    }
    
    
    // MARK: - UITextFieldDelegate and related methods
    // -----------------------------------------------
    
    // Enable the "Get weather for the city above" button
    // if the city text field contains any text,
    // disable it otherwise.
    /*
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(
            in: range,
            with: string)
        getCityWeatherButton.isEnabled = prospectiveText.count > 0
        print("Count: \(prospectiveText.count)")
        return true
    }
    */
    
    // Pressing the clear button on the text field (the x-in-a-circle button
    // on the right side of the field)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        // Even though pressing the clear button clears the text field,
        // this line is necessary. I'll explain in a later blog post.
        textField.text = ""
        return true
    }
    
    
    // Pressing the return button on the keyboard should be like
    // pressing the "Get weather for the city above" button.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        // < ===== ======>
        getWeatherForCityButtonTapped(sender: getCityWeatherButton)
        return true
    }
    
    // Tapping on the view should dismiss the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Utility methods
    // -----------------------
    
    func showSimpleAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(
            title: "OK",
            style:  .default,
            handler: nil
        )
        alert.addAction(okAction)
        present(
            alert,
            animated: true,
            completion: nil
        )
    }
    
    func readDataFromFile(file:String)-> String!{
        guard Bundle.main.path(forResource: file, ofType: "txt") != nil
            else {
                return nil
        }
        do {
            let filepath:String = Bundle.main.path(forResource: "CityList", ofType: "txt")!
            return try? String(contentsOfFile: filepath, encoding: String.Encoding.utf8)
            
            //let contents = try String(contentsOfFile: filepath, usedEncoding: nil)
            //return contents
        } catch {
            print ("File Read Error")
            return nil
        }
        
    }
    
}



/*
extension String {
    
    // A handy method for %-encoding strings containing spaces and other
    // characters that need to be converted for use in URLs.
    var urlEncoded: String {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return self.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLUserAllowedCharacterSet())!
    }
    
}
 */

