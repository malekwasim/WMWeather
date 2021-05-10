//
//  UIStoryboard.swift
//  MQWeather
//
//  Created by Wasim on 07/05/21.
//

import UIKit

extension UIStoryboard {
    
    /// The uniform place where we state all the storyboard we have in our application
    
    enum Storyboard: String {
        case Main
        case Weather
        case Help
        
        var filename: String {
            return rawValue
        }
    }
    
    // MARK: - Convenience Initializers
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - View Controller Instantiation from Generics
    
    func instantiateViewController<T: UIViewController>() -> T where T: StoryboardIdentifiable {
        guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier) ")
        }
        
        return viewController
    }
}

protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController : StoryboardIdentifiable { }

//MARK: - Main
extension UIStoryboard {
    static var main: UIStoryboard {
        return UIStoryboard(storyboard: .Main)
    }
    static var homeVC: HomeViewController {
        return UIStoryboard.main.instantiateViewController()
    }
    static var mapVC: MapViewViewController {
        return UIStoryboard.main.instantiateViewController()
    }
}

//MARK: - Weather
extension UIStoryboard {
    static var weather: UIStoryboard {
        return UIStoryboard(storyboard: .Weather)
    }
    static var weatherVC: WeatherViewController {
        return UIStoryboard.weather.instantiateViewController()
    }
}

//MARK: - Help
extension UIStoryboard {
    static var help: UIStoryboard {
        return UIStoryboard(storyboard: .Help)
    }
    static var helpVC: HelpViewController {
        return UIStoryboard.help.instantiateViewController()
    }
}
