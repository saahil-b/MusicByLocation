//
//  ContentView.swift
//  MusicByLocation
//
//  Created by Rakesh Bahadur on 13/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var state = StateController()
    
    var body: some View {
        VStack {
            Text(state.lastKnownLocation)
                .padding()
            Text(state.artistNames)
                .padding()
            Divider()
            Button("Find music", action: {
                state.findMusic()
            })
            
        }.onAppear(perform: {
            state.requestAccessToLocationData()
            state.getArtists()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
