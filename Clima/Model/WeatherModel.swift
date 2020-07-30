//
//  WeatherModel.swift
//  Clima
//
//  Created by Rohit sahu on 23/07/20.

//

import Foundation


struct WeatherModel{
    let id : Int
    let description : String
    let temp : Double
    let name: String
     
    var tempratureString : String{return String(format: "%0.1f",temp)}
    
    var conditionName : String {
        switch id {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    
    }
    
    
}
