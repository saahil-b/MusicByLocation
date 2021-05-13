//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 13/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var locationHandler = LocationHandler()
    
    var body: some View {
        VStack {
            Text(locationHandler.lastKnownLocation)
                .padding()
            Spacer()
            Button("Find music", action: {
                locationHandler.requestLocation()
            })
            
        }.onAppear(perform: {
            locationHandler.requestAuthorisation()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
