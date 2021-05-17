//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 13/05/2021.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    weak var stateController: StateController?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestAuthorisation() {
        manager.requestWhenInUseAuthorization()
        manager.delegate = self
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil{
                    self.stateController?.lastKnownLocation = "Could not perform lookup of coordinate info"
                } else {
                    if let firstPlaceMark = placemarks?[0] {
                        self.stateController?.lastKnownLocation = firstPlaceMark.getLocationBreakdown()
                        self.stateController?.searchTerm = firstPlaceMark.locality ?? (firstPlaceMark.country ?? "Error")
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        stateController?.lastKnownLocation = "Error finding location"
    }
}
