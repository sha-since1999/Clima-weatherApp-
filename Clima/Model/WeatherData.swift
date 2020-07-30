//
//  WeatherData.swift
//  Clima
//
//  Created by Rohit sahu on 23/07/20.

//

import Foundation

struct WeatherData : Decodable{
    let name : String
    let weather : [Weather]
    let main : Main
    
}
struct  Main :Decodable {
    let temp : Double
}

struct Weather : Decodable {
    let  description : String
    let id : Int
}

