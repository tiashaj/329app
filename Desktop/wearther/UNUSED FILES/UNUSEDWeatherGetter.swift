//
//  WeatherGetter.swift
//  wearther
//
//  Created by Kevin Zhang on 4/24/18.
//  Copyright © 2018 Amy Fang. All rights reserved.
//
/*
import Foundation

class WeatherGetter {
    
    //http://api.openweathermap.org/data/2.5/weather?q=Austin&appid=a32b6bd4c4bd5b7f579aadb04621a288
    private let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
    private let openWeatherMapAPIKey = "a32b6bd4c4bd5b7f579aadb04621a288"
    
    func getWeather(city: String) {
        
        // This is a pretty simple networking task, so the shared session will do.
        let session = URLSession.shared
        
        let weatherRequestURL = NSURL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
        
        // The data task retrieves the data.
        let dataTask = session.dataTask(with: weatherRequestURL as URL)
        {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                // Case 1: Error
                // We got some kind of error while trying to get data from the server.
                print("Error:\n\(error)")
            }
            else {
                // Case 2: Success
                // We got a response from the server!
                do {
                    // Try to convert that data into a Swift dictionary
                    let weather = try JSONSerialization.jsonObject(
                        with: data!,
                        options: .mutableContainers) as! [String: AnyObject]
                    
                    // If we made it to this point, we've successfully converted the
                    // JSON-formatted weather data into a Swift dictionary.
                    // Let's print its contents to the debug console.
                    print("Date and time: \(weather["dt"]!)")
                    print("City: \(weather["name"]!)")
                    
                    print("Longitude: \(weather["coord"]!["lon"]!!)")
                    print("Latitude: \(weather["coord"]!["lat"]!!)")
                    
                    print("Weather ID: \((weather["weather"]![0]! as! [String:AnyObject])["id"]!)")
                    print("Weather main: \((weather["weather"]![0]! as! [String:AnyObject])["main"]!)")
                    print("Weather description: \((weather["weather"]![0]! as! [String:AnyObject])["description"]!)")
                    print("Weather icon ID: \((weather["weather"]![0]! as! [String:AnyObject])["icon"]!)")
                    
                    print("Temperature: \(weather["main"]!["temp"]!!)")
                    print("Humidity: \(weather["main"]!["humidity"]!!)")
                    print("Pressure: \(weather["main"]!["pressure"]!!)")
                    
                    print("Cloud cover: \(weather["clouds"]!["all"]!!)")
                    
                    print("Wind direction: \(weather["wind"]!["deg"]!!) degrees")
                    print("Wind speed: \(weather["wind"]!["speed"]!!)")
                    
                    //print("Country: \(weather["sys"]!["country"]!!)")
                    //print("Sunrise: \(weather["sys"]!["sunrise"]!!)")
                    //print("Sunset: \(weather["sys"]!["sunset"]!!)")
                }
                catch let jsonError as NSError {
                    // An error occurred while trying to convert the data into a Swift dictionary.
                    print("JSON error description: \(jsonError.description)")
                }
            }
        }
        
        // The data task is set up...launch it!
        dataTask.resume()
    }
    
}
*/
