

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var secondContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        secondContentView.layer.cornerRadius = 20
    }

    func configureTwo (forecast: Forecast?, indexPath: IndexPath) {
        
        if let forecast = forecast {
            if let list = forecast.list {
                
                let row = list[indexPath.row]
                timeLabel.text = row.dt_txt
                
                if let main = row.main {
                    
                    tempLabel.text = String(main.temp ?? 0) + "ºC"
                    
//                    if let info = row.weather {
//
//
//                        descriptionLabel.text = list[0].weather?[0].description
//                        stateImageView.image = UIImage(named: info[0].icon ?? "images")
//                    }
                    
                    
                    
                    
                    
                    
                    if let info = row.weather {


                        descriptionLabel.text = DataSource.weatherIDs[info[0].id ?? 0]
                        stateImageView.image = UIImage(named: info[0].icon ?? "images")
                    }
                } else { print("main Wrong")}
            }
        }
    }
}
