//
//  StateController.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 17/05/2021.
//

import Foundation

class StateController: ObservableObject {
    @Published var lastKnownLocation: String = ""
    @Published var artistNames: String = ""
    @Published var searchTerm: String = ""
    
    let locationHandler = LocationHandler()
    
    func findMusic() {
        self.locationHandler.requestLocation()
    }
    
    func requestAccessToLocationData() {
        locationHandler.stateController = self
        self.locationHandler.requestAuthorisation()
    }
    
    func getArtists() {
        let searchString = self.searchTerm.formatForSearch()
        
        guard let url = URL(string: "https://itunes.apple.com/search?terms=\(searchString)&entity=song")
        else {
            print("bad url")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            if let data = data {
                
                if let response = self.parseJson(json: data) {
                    let names = response.results.map {
                        return $0.name
                    }
                    
                    DispatchQueue.main.async {
                        self.artistNames = names.joined(separator: ", ")
                    }
                }
                
                
                
            }
        }.resume()
        
    }
    
    func parseJson(json: Data) -> ArtistResponse? {
        let decoder = JSONDecoder()
        
        if let artistResponse = try? decoder.decode(ArtistResponse.self, from: json) {
            return artistResponse
        } else {
            print("Error decoding JSON")
            return nil
        }
        
    }
}
