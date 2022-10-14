
import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var newTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var text: String?
    var weatherLocation = DataWeatherLocation()
    var language = Locale.preferredLanguages[0]
    
    let locationManager = CLLocationManager()
    var array = [ "","Moscow", "London", "Minsk", "Paris", "Berlin",]

    let weather = DatWeather()
    let forecast = Forecast()
    let viewModel = ViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
       print( language )
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        continueButton.setTitle("Continue".localized(), for: .normal)
    }
    
    
    @IBAction func textButtonPreseed(_ sender: UIButton) {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController else { return }
        guard textField.text != "" else { return }
        guard let text = textField.text else { return }
        
        controller.text = text
        navigationController?.pushViewController(controller, animated: true)
    }
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = false
            locationManager.startUpdatingLocation()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ViewControllerTableViewCell", for: indexPath) as? ViewControllerTableViewCell else { return UITableViewCell()}
        
        viewModel.sendRequest(text: array[indexPath.row], language: language) { [weak self] (weather) in
            
            DispatchQueue.main.async {
                if indexPath.row == 0 {
                    cell.configureLocation(weatherLocation: self?.weatherLocation)
                } else {
                    cell.configure(weather: weather, indexPath: indexPath, text: self?.array[indexPath.row] ?? "error")
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController else { return }
        
        for (index, value) in array.enumerated() {
            if index == indexPath.row {
                
                if indexPath.row == 0 {
                    
                    controller.text =  weatherLocation.name ?? "Error in didSelectRow"
                    navigationController?.pushViewController(controller, animated: true)
                    
                } else {
                    
                    controller.text = value
                    navigationController?.pushViewController(controller, animated: true)
                }
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            
            viewModel.updateWeatherInfoLocation(latitude: lastLocation.coordinate.latitude, lontitude: lastLocation.coordinate.longitude) { [weak self] (weather) in
                
                DispatchQueue.main.async {
                    self?.weatherLocation = weather
                    self?.newTableView.reloadData()
                }
                print(weather)
            }
        }
    }
}












