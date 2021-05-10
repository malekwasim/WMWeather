//
//  MapViewViewController.swift
//  MQWeather
//
//  Created by Wasim on 07/05/21.
//

import UIKit
import MapKit

internal final class MapViewViewController: BaseViewController {

    //MARK: Outlets
    @IBOutlet weak var mapView: MKMapView!
    var selectedLocation: CLLocationCoordinate2D?
    
    //MARK: - View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    private func setupView() {
        setupMapGesture()
        setSaveNavBar()
    }
    
    func setSaveNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(btnSaveTapped(_:)))
        self.navigationItem.setRightBarButton(addButton, animated: true)
    }
    
    @objc func btnSaveTapped(_ sender: UIButton) {
        
        guard let coordinate = selectedLocation else {
            return
        }
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error:", error ?? "nil")
                return
            }
            UserCitiesDBManager.shared.save(coordinate.latitude, longitude: coordinate.longitude, name: placemark.city)
            self.pop()
        }
    }
    
    func setupMapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped(_:)))
        tapGesture.numberOfTapsRequired = 1
        mapView.addGestureRecognizer(tapGesture)
    }
    
    @objc func mapViewTapped(_ sender: UITapGestureRecognizer) {
        let ann = mapView.annotations
        mapView.removeAnnotations(ann)
        let point = sender.location(in: mapView)
        selectedLocation = mapView.convert(point, toCoordinateFrom: view)
        let annotation = MKPointAnnotation()
        if let location = selectedLocation {
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
        }
        
    }
    

}
