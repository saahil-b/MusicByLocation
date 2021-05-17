//
//  Artist.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 17/05/2021.
//

import Foundation

struct Artist: Codable {
    var name: String
    
    private enum CodingKeys: String, CodingKey {
        case name = "artistName"
    }
}
