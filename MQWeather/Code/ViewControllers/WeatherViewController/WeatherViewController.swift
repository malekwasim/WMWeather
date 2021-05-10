//
//  WeatherViewController.swift
//  MQWeather
//
//  Created by Wasim on 08/05/21.
//

import UIKit

internal final class WeatherViewController: BaseViewController {

    //MARK: - Outlets
    @IBOutlet weak var viewWeather: WeatherView!
    //MARK: - Properties
    var city: UserCities?
    var weatherResult: Result?
    
    //MARK - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        self.title = "Weather"
        viewWeather.setupCity(city)
        getWeatherDetails()
    }
    
    func getWeatherDetails() {
        NetworkLayer.shared.setLatitude(city?.latitude ?? 0.0)
        NetworkLayer.shared.setLongitude(city?.longitude ?? 0.0)
        NetworkLayer.shared.getWeather { (result) in
            self.weatherResult = result
            self.viewWeather.setupView(self.weatherResult)
        } onError: { (error) in
            print(error)
        }
    }


}
