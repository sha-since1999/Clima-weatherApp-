//
//  WeatherManager.swift
//  Clima
//

import Foundation


protocol WeatherManagerDelegate{
    func weatherManagerDidUpdate(_ weather : WeatherModel)
    func DidFailWithError(_ error : Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=afsdfkasnfaosidfoawief&units=metric"
    
   
    var delegate : WeatherManagerDelegate? = nil

    func fetchWeather(cityName : String ) {

        let urlString = "\(weatherURL)&q=\(cityName)"
        
        self.performRequest(with : urlString) /// here self only for declare method of same class
    }
    
    func fetchWeather(withLatitude lat : Double ,longitude lon :Double ) {

           let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
           
           self.performRequest(with : urlString) /// here self only for declare method of same class
       }
    
    func  performRequest(with urlString : String )
    {
           // firslty creating a url  form string
        
           if let url = URL( string : urlString)
           {
               // now create   a session for url
               let session = URLSession(configuration : .default)
                // now give a session task
               
               let task = session.dataTask( with : url){(data, response ,error) in
                
                    if error != nil
                    {
                        self.delegate?.DidFailWithError(error!)
                    }
                    if let safeData = data
                    {
        
                       //let dataString = String( data : safeData ,encoding : .utf8)
                       //print(dataString!)
                        
                        if let weatherModel = self.parseJSON(safeData)
                        {
                            self.delegate?.weatherManagerDidUpdate(weatherModel)
                        }
                   }
               }
                
               // strat the task
               task.resume()   
               
           }
           
       }
    
     func parseJSON(_ safeData : Data) ->WeatherModel?
     {
        let decoder = JSONDecoder()
        do
        {
            let decodedData = try  decoder.decode(WeatherData.self , from: safeData)
        
            
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let description = decodedData.weather[0].description
            let name = decodedData.name
            let weathermodel = WeatherModel(id: id, description: description, temp: temp, name :name)

            return weathermodel
            
         }
        catch
        {
            print(error)
            
            return nil
        }
        
    }
       
    
    
      
       
       
}
