

import UIKit

class MainPageViewController: UIViewController {
    
    var text = ""
    var weather: DatWeather?
    var forecast: Forecast?
    var textTwo = ""
    
    
    @IBOutlet weak var windSpeedHeaderLabel: UILabel!
    @IBOutlet weak var pressureHeaderLabel: UILabel!
    @IBOutlet weak var humidityHeaderLabel: UILabel!
    @IBOutlet weak var feelsLikeHeaderLabel: UILabel!
    @IBOutlet weak var sunriseHeaderLabel: UILabel!
    @IBOutlet weak var sunsetHeaderLabel: UILabel!
    @IBOutlet weak var tempMinHeaderLabel: UILabel!
    @IBOutlet weak var tempMaxHeaderLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var thirdView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    
    @IBOutlet weak var currentTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        JSONMan.shared.sendRequest(text: text) { (weather) in
            DispatchQueue.main.async {
                
                self.apdateWeather(weather)
            }
        }
        
        JSONMan.shared.sendForecastRequest(text: text) { (forecast) in
            
            DispatchQueue.main.async {
                self.forecast = forecast
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        windSpeedHeaderLabel.text = "wind speed".localized()
        pressureHeaderLabel.text = "presure".localized()
        humidityHeaderLabel.text = "humidity".localized()
        feelsLikeHeaderLabel.text = "feels-like".localized()
        sunriseHeaderLabel.text = "sunrise".localized()
        sunsetHeaderLabel.text = "sunset".localized()
        tempMinHeaderLabel.text = "temp min".localized()
        tempMaxHeaderLabel.text = "temp max".localized()
    }
    
    private func apdateWeather (_ weather: DatWeather?) {
        
        guard let temppp = weather?.name else { return }
        
        self.cityLabel.text = "\(String(describing: temppp))"
        self.conditionLabel.text = DataSource.weatherIDs[weather?.weather?[0].id ?? 0]
        self.temperatureLabel.text = String(weather?.main?.temp ?? 0.0) + "ºC"
        self.iconImageView.image = UIImage(named: weather?.weather?[0].icon ?? "images")
        self.windSpeedLabel.text =  String(describing: weather?.wind?.speed ?? 0.0) + "m/s"
        self.feelsLikeLabel.text = String(describing: weather?.main?.feels_like ?? 0.0)
        self.pressureLabel.text = String(describing: weather?.main?.pressure ?? 0.0)
        self.humidityLabel.text = String(describing: weather?.main?.humidity ?? 0.0)
        
        self.currentTimeLabel.text = createData(weather: weather)
    }
    
    private func createData(weather: DatWeather? ) -> String{
        
        let date = Date()
        print(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        formatter.timeZone = TimeZone(secondsFromGMT: weather?.timezone ?? 0)
        return formatter.string(from: date)
    }
}

extension MainPageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return forecast?.list?.count ?? 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }

        
        cell.configureTwo(forecast: forecast, indexPath: indexPath)
        return cell
    }
}



