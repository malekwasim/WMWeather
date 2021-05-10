//
//  UserCities+CoreDataClass.swift
//  MQWeather
//
//  Created by Wasim on 08/05/21.
//
//

import Foundation
import CoreData

@objc(UserCities)
public class UserCities: NSManagedObject {

    func save(_ id: Int64,latitude: Double?, longitude: Double?, name: String?) {
        self.id = id
        self.latitude = latitude ?? 0.0
        self.longitude = longitude ?? 0.0
        self.name = name
    }
}
