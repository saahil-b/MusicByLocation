//
//  StateController.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 17/05/2021.
//

import Foundation

class StateController: ObservableObject {
    let locationHandler = LocationHandler()
    let iTunesAdaptor = ITunesAdaptor()
    
    @Published var artistsByLocation: [String] = []
    
    var lastKnownLocation: String = "..." {
        didSet {
            iTunesAdaptor.getArtists(search: lastKnownLocation, completion: updateArtistsByLocation)
            }
        }
    
    func findMusic() {
        self.locationHandler.requestLocation()
    }
    
    func updateArtistsByLocation(artists: [Artist]?) {
        let names = artists?.map { return $0.name }
        
        DispatchQueue.main.async {
            self.artistsByLocation = names ?? ["Error finding artists"]
        }
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        self.locationHandler.requestAuthorisation()
    }
    
    
}
