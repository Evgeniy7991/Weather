

import UIKit

class ViewControllerTableViewCell: UITableViewCell {
    
    
//    Locale.preferredLanguages[0]
    
    @IBOutlet weak var newTableView: UITableView!
    
    @IBOutlet weak var capitalNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var idIconImageView: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
    func configure (weather: DatWeather?, indexPath: IndexPath, text: String ) {
        
        self.capitalNameLabel.text = text
        if let weather = weather {
            if let main = weather.main {
                
                if let temp = main.temp {
                    tempLabel.text = String(temp) + "ºC"
                }
                if let humidity = main.humidity {
                    self.humidity.text = String(humidity) + "g/m³"
                }
                if let feelsLike = main.feels_like {
                    self.feelsLike.text = String(feelsLike) + "ºC"
                }
            }
            if let wind = weather.wind {
                if let windSpeed = wind.speed {
                    self.windSpeed.text = String(windSpeed) + "km/h"
                }
            }
            if let object = weather.weather {
                if let nameIcon = object[0].icon {
                
                self.idIconImageView.image = UIImage(named: nameIcon)
                }
            }
        }
    }
    
    func configureLocation(weatherLocation: DataWeatherLocation? ) {
        
        self.capitalNameLabel.text = "Current location"
        if let weather = weatherLocation {
            if let main = weather.main {
                
                if let temp = main.temp {
                    tempLabel.text = String(temp) + "ºC"
                }
                if let humidity = main.humidity {
                    self.humidity.text = String(humidity) + "g/m³"
                }
                if let feelsLike = main.feels_like {
                    self.feelsLike.text = String(feelsLike) + "ºC"
                }
            }
            if let wind = weather.wind {
                if let windSpeed = wind.speed {
                    self.windSpeed.text = String(windSpeed) + "km/h"
                }
            }
            if let object = weather.weather {
                if let nameIcon = object[0].icon {
                    
                    self.idIconImageView.image = UIImage(named: nameIcon)
                }
            }
        }
    }
}
