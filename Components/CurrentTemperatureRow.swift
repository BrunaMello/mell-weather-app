//
//  CurrentTemperatureRow.swift
//  mell weather app
//
//  Created by Bruna Mello on 30/05/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct CurrentTemperatureRow: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    
    @State private var weather: Weather?
    
    var body: some View {
        VStack {
            if let weather {
                HStack(alignment: .center) {
                    VStack {
                        Image(systemName: "\(weather.currentWeather.symbolName)")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 60)
                            .foregroundColor(.yellow)
                        
                        Text("\(weather.currentWeather.condition.description)")
                            .font(.subheadline)
                    }.frame(width: 100, height: 200)
                    
                    Text("\(Int((weather.currentWeather.temperature.value).rounded()))ºC")
                        .font(.system(size: 100))
                        .fontWeight(.bold)
                    
                }
            }
        }.frame(maxWidth: .infinity, alignment: .center)
         .task(id: locationManager.currentLocation) {
            do {
//                if let location = locationManager.currentLocation {
                let location = CLLocation(latitude: 53.328456, longitude: -6.263981)
                    self.weather = try await weatherService.weather(for: location)
//                }
            } catch {
                print(error)
            }

        }
    }
}

struct CurrentTemperatureRow_Previews: PreviewProvider {
    static var previews: some View {
        CurrentTemperatureRow()
    }
}
