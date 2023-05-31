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
            if weather != nil {
                WeatherView()
            }
        }
            .background(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
            .task(id: locationManager.currentLocation) {
            do {
                if let location = locationManager.currentLocation {
//                let location = CLLocation(latitude: 53.328456, longitude: -6.263981)
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
