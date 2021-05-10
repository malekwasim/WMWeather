//
//  WeatherView.swift
//  MQWeather
//
//  Created by Wasim on 09/05/21.
//

import UIKit

class WeatherView: UIView {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTemp: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setupCity(_ city: UserCities?) {
        lblCity.text = city?.name
    }
    
    func setupView(_ result: Result?) {
        guard let weather = result else {
            return
        }
        
        lblDesc.text = "\(weather.current.weather.first?.description ?? "")"
        lblTemp.text = "\(weather.current.temp)"
        lblWindSpeed.text = "Wind: \(weather.current.wind_speed)"
        lblHumidity.text = "Humidity: \(weather.current.humidity)"
        iconImage.image = UIImage(named: weather.current.weather[0].icon)
    }

}
