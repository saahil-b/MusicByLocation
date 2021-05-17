//
//  ArtistResponse.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 17/05/2021.
//

import Foundation

struct ArtistResponse: Codable {
    let count: Int
    let results: [Artist]
    
    private enum CodingKeys: String, CodingKey {
        case count = "resultCount"
        case results
    }
}
