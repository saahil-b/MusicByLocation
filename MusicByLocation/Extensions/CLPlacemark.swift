//
//  CLPlacemark.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 17/05/2021.
//

import Foundation
import CoreLocation

extension CLPlacemark {
    func getLocationBreakdown() -> String{
        return
            """
            Street: \(self.thoroughfare ?? "None")
            City: \(self.locality ?? "None")
            Area: \(self.administrativeArea ?? "None")
            Country: \(self.country ?? "None")
            """
    }
}
