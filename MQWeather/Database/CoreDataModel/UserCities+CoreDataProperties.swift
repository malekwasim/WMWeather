//
//  UserCities+CoreDataProperties.swift
//  MQWeather
//
//  Created by Wasim on 08/05/21.
//
//

import Foundation
import CoreData


extension UserCities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCities> {
        return NSFetchRequest<UserCities>(entityName: "UserCities")
    }
    
    class func request() -> NSFetchRequest<UserCities> {
        return fetchRequest()
    }

    @NSManaged public var id: Int64
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?

}

extension UserCities : Identifiable {

}
