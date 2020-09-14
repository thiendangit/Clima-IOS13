//
//  Weather.swift
//  Clima
//
//  Created by Thiện Đăng on 9/11/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


struct WeatherData : Decodable {
    let name : String
    let main : Main
    let coord : coord
    let weather : [weather]
    var timezone: Int
    let id: Int
    let cod: Int
}

struct Main : Decodable {
    let temp : Double
    let feels_like: Double
    let temp_min : Double
    let temp_max : Double
    let pressure : Int
    let humidity : Int
}

struct coord : Decodable {
    let lon : Float
    let lat : Float
}

struct weather : Decodable {
    let id : Int
    let main : String
    let description : String
    let icon : String
}
