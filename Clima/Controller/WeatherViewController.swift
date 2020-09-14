

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, UITextFieldDelegate, weatherProtocol {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    var weather = WeatherManager()
    let location = CLLocationManager()
    @IBOutlet weak var textInputSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textInputSearch.delegate = self
        weather.delegate = self
        location.delegate = self
        location.requestWhenInUseAuthorization()
        location.requestLocation()
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text ?? "nothing")
        _ = weather.fetchWeather(cityName: textField.text ?? "Lodon")
        textInputSearch.text = ""
        return true
    }
    
    @IBAction func onPressSearch(_ sender: UIButton) {
        textInputSearch.endEditing(true)
        print("\(textInputSearch?.text ?? "data")")
        weather.fetchWeather(cityName: textInputSearch.text ?? "Lodon")
        textInputSearch.text = ""
    }
    
    @IBAction func getLocationButton(_ sender: UIButton) {
        location.requestLocation()
       }
    
    func shouldBeUpdateWeather(weather : WeatherModel?) -> Void {
        print(weather?.conditionName ?? "")
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(weather?.temperature ?? 0.0)
            self.cityLabel.text = "\(weather?.cityName ?? "")"
            self.conditionImageView.image = UIImage(systemName : weather?.conditionName ?? "cloud.bolt" )!
        }
    }
    
}

extension WeatherViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("got a Location")
        if let location_result = locations.last{
            location.stopUpdatingLocation()
            let lat_ = location_result.coordinate.latitude
             let lng_ = location_result.coordinate.longitude
            weather.fetchWeather(lat : lat_, lng : lng_)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("\(error)")
    }
    
}

