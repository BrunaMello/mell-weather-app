//
//  ContentView.swift
//  mell weather app
//
//  Created by Bruna Mello on 27/05/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct ContentView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @State private var weather: Weather?
    
    
    var body: some View {
        VStack {
            if let weather {
                    WeatherView()
                }
            
//            if let location = locationManager.location {
//                Text("Your coordinates are: \(location.longitude), \(location.latitude).")
//            } else {
//                if locationManager.isLoading {
//                    LoadingView()
//                } else {
//                    WeatherView()
//                        .environmentObject(locationManager)
//                }
//            }
            
            
        }
//        .background(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
//        .preferredColorScheme(.dark)
        .task(id: locationManager.currentLocation) {
            do {
                if let location = locationManager.currentLocation {
                    self.weather = try await weatherService.weather(for: location)
                }
            } catch {
                print(error)
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
