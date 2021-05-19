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
            
            Spacer()
            
            Text("Artists in \(state.lastKnownLocation)").font(.largeTitle)
            
            Divider()
                        
            List(state.artistsByLocation, id: \.self) {
                Text($0).padding()
            }
            
            Divider()
            
            Button("Find music", action: {
                state.findMusic()
            })
            
        }.onAppear(perform: {
            state.requestAccessToLocationData()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
