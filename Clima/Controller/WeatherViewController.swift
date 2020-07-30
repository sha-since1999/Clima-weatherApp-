
import UIKit
import CoreLocation
class WeatherViewController: UIViewController  {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weathermanager = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weathermanager.delegate = self
        searchTextField.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: Any)
    {
        searchTextField.endEditing(true)
    }
    
    @IBAction func locationIconPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}


//MARK: - TextFielDeligate

extension WeatherViewController : UITextFieldDelegate
{
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            searchTextField.endEditing(true)
               return true  // this function call when user pressed enter in the keyboard
           }


    //    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    //        searchTextField.text = "you cant type more"
    //        return false
    //    }       //should function always akss to the developer what to do if tha operationis is start perform
       
        
        func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
            if  textField.text != ""
            {
                return true
            }
            else {
                textField.placeholder = "type something ..."
                return false
            }
        }
        func textFieldDidEndEditing(_ textField: UITextField) {
    //        print(searchTextField.text!)
            if let city = textField.text
            {
                weathermanager.fetchWeather(cityName : city)
    //            cityLabel.text = city
            }
            
            textField.text = ""
        }
}



//MARK: - WeatherManagerDelegate


extension WeatherViewController : WeatherManagerDelegate
{
    func weatherManagerDidUpdate(_ weather: WeatherModel) {
        
          DispatchQueue.main.async {
              self.temperatureLabel.text = weather.tempratureString
              self.conditionImageView.image = UIImage.init(systemName: weather.conditionName)
            self.cityLabel.text = weather.name
          }
          
      }
    func DidFailWithError(_ error : Error)
    {
         print(error)
    }
    
}

//MARK: - CLLocationMangerDelegate

extension WeatherViewController : CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last
        {
        locationManager.stopUpdatingLocation()
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
//        print(lat)
//        print(lon)
        weathermanager.fetchWeather(withLatitude : lat ,longitude :lon)
        
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
