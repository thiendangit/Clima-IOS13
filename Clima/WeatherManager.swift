//
//  WeatherManager.swift
//  Clima
//
//  Created by Thiện Đăng on 9/11/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


protocol weatherProtocol {
    func shouldBeUpdateWeather(weather : WeatherModel?)
}

struct WeatherManager {
    let Weather_Url : String = "https://api.openweathermap.org/data/2.5//weather?"
    let App_Id : String = "32e25010b84753f2fbb5845308caf82c"
    let units : String = "metric"
    
    var delegate : weatherProtocol! = nil
    
    func fetchWeatherByName(cityName : String) -> Void {
        let URL = "\(Weather_Url)q=\(cityName)&appid=\(App_Id)&units=\(units)"
        performRequest(URLRequest : URL)
    }
    
    func performRequest(URLRequest : String) -> Void {
        if let urlString = URL(string : URLRequest) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlString, completionHandler:{
                (data : Data?, responese : URLResponse?, error : Error?) -> Void in
                if(error != nil){
                    print("Something went wrong !!!")
                    print(error!)
                    return
                }
                if let safeData = data {
                    let result = self.JsonDecode(weatherData: safeData)
                    self.delegate!.shouldBeUpdateWeather(weather: result ?? nil)
                }
            })
            //start fetch
            task.resume()
        }
    }
    
    func JsonDecode(weatherData : Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let name = decodeData.name
            let temperature = decodeData.main.temp
            let weatherModel = WeatherModel(conditionId: id, cityName: name, temperature : temperature)
            return weatherModel
        } catch {
            print(error)
            return nil
        }
    }
}
