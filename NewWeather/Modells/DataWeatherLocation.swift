

import Foundation

struct WeatherLocation: Decodable {
    
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct MainLocation: Decodable {
    
    var temp: Double?
    var feels_like: Double?
    var pressure: Double?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
}

struct WindLocation: Decodable {
    var speed: Double?
}

struct SysLocation: Decodable {
    var sunrise: Int?
    var sunset: Int?
}

struct DataWeatherLocation: Decodable {
    
    var weather: [WeatherLocation]?
    var main: MainLocation?
    var wind: WindLocation?
    var dt: Int?
    var sys: SysLocation?
    var id: Int?
    var timezone: Int?
    var name: String?
}
