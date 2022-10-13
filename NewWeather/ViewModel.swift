

import Foundation

class ViewModel {
    
    let weatherModel = Bindable<DatWeather>(DatWeather())
    
    func sendRequest( text: String, completion: @escaping (DatWeather)->()) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(text)&units=metric&lang=ru&appid=4d0130acb14062d5a07ba908bf7112f2" ) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { (data, responce, error) in
            
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(DatWeather.self, from: data)
                completion(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func updateWeatherInfoLocation(latitude: Double, lontitude: Double, completion: @escaping (DataWeatherLocation)->()) {
        
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(lontitude.description)&units=metric&lang=en&appid=4d0130acb14062d5a07ba908bf7112f2") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            
            do {
                let json = try JSONDecoder().decode(DataWeatherLocation.self, from: data)
                
                completion(json)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}


