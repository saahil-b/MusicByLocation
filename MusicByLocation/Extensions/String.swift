//
//  String.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 17/05/2021.
//

import Foundation

extension String {
    func formatForSearch() -> String{
        
        var arr: [String] = []
        
        for char in self {
            if char == " " {
                arr.append("%20")
            } else {
                arr.append(String(char))
            }
        }
        
        return arr.joined()
    }
}
