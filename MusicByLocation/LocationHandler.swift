//
//  LocationHandler.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 13/05/2021.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject, CLLocationManagerDelegate, ObservableObject {
    let manager = CLLocationManager()
    let geocoder = CLGeocoder()
    @Published var lastKnownLocation: String = ""
    
    
    
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
        
        var country = ""
        var city = ""
        var town = ""
        
        if let firstLocation = locations.first {
            geocoder.reverseGeocodeLocation(firstLocation, completionHandler: { (placemarks, error) in
                if error != nil{
                    self.lastKnownLocation = "Could not perform lookup of coordinate info"
                } else {
                    if let firstPlaceMark = placemarks?[0] {
                        country = firstPlaceMark.country ?? "Couldn't find country"
                        city = firstPlaceMark.locality ?? "Couldn't find city"
                        town = firstPlaceMark.subLocality ?? "Couldn't find town"
                        
                        self.lastKnownLocation = "\(town)\n\(city)\n\(country)"
                    }
                }
            })
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lastKnownLocation = "Error finding location"
    }
}
