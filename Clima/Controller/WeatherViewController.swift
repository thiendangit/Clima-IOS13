

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, weatherProtocol {
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    var weather = WeatherManager()
    @IBOutlet weak var textInputSearch: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textInputSearch.delegate = self
        weather.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        print(textField.text ?? "nothing")
        _ = weather.fetchWeatherByName(cityName: textField.text ?? "Lodon")
        textInputSearch.text = ""
        return true
    }
    
    @IBAction func onPressSearch(_ sender: UIButton) {
        textInputSearch.endEditing(true)
        print("\(textInputSearch?.text ?? "data")")
        weather.fetchWeatherByName(cityName: textInputSearch.text ?? "Lodon")
        textInputSearch.text = ""
    }
    
    func shouldBeUpdateWeather(weather : WeatherModel?) -> Void {
        print(weather?.conditionName ?? "")
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(weather!.temperature)
            self.cityLabel.text = "\(weather?.cityName ?? "")"
            self.conditionImageView.image = UIImage(systemName : weather!.conditionName)!
        }
    }
    
}

