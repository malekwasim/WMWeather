//
//  MQWeatherTests.swift
//  MQWeatherTests
//
//  Created by Wasim on 07/05/21.
//

import XCTest
import MapKit
@testable import MQWeather

class MQWeatherTests: XCTestCase {

    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testAddCity() {
        let coordinate = CLLocationCoordinate2D(latitude: 17.3850, longitude: 78.4867)
        let city = "Hyderabad"
        UserCitiesDBManager.shared.save(coordinate.latitude, longitude: coordinate.longitude, name: city)
        let userCity = UserCitiesDBManager.shared.getLastRecord()
        
        XCTAssertEqual(userCity?.latitude, coordinate.latitude)
        XCTAssertEqual(userCity?.longitude, coordinate.longitude)
        XCTAssertEqual(userCity?.name, city)
        
        UserCitiesDBManager.shared.removeCity(userCity?.id ?? 0)	
    }

}
