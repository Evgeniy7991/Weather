

import Foundation

struct Weather: Decodable {
    
    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}

struct Main: Decodable {
    
    var temp: Double?
    var feels_like: Double?
    var pressure: Double?
    var humidity: Double?
    var temp_min: Double?
    var temp_max: Double?
}

struct Wind: Decodable {
    var speed: Double?
}

struct Sys: Decodable {
    var sunrise: Int?
    var sunset: Int?
}

struct DatWeather: Decodable {
    
    var weather: [Weather]?
    var main: Main?
    var wind: Wind?
    var dt: Int?
    var sys: Sys?
    var id: Int?
    var timezone: Int?
    
    var name: String?
}

