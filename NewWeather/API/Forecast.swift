

import Foundation


struct Forecast: Decodable {
   
    var list: [List]?
}

struct List: Decodable {
    
    var dt: Int?
    var main: ForecastMain?
    var weather: [ForecastWeather]?
    var dt_txt: String?
}

struct ForecastMain: Decodable {
    
    var temp: Double?
    var humidity: Int?
    var feels_like: Double?
    var temp_min: Double?
    
}

struct ForecastWeather: Decodable {

    var id: Int?
    var main: String?
    var description: String?
    var icon: String?
}
