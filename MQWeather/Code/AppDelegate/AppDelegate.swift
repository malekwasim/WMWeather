//
//  AppDelegate.swift
//  MQWeather
//
//  Created by Wasim on 07/05/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        _ = DBManager.sharedDB.persistentContainer
        return true
    }


    
}

