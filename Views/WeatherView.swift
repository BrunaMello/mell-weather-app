//
//  WeatherView.swift
//  mell weather app
//
//  Created by Bruna Mello on 27/05/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct WeatherView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @State private var weather: Weather?
    
    
    var hourWeatherData: [HourWeather] {
        if let weather {
            return Array(weather.hourlyForecast.filter { hourlyWeather in
                return hourlyWeather.date.timeIntervalSince(Date()) >= 0
            }.prefix(24))
        } else {
            return []
        }
    }
    
    
    var body: some View {
        ZStack(alignment: .leading){
            VStack {
                DateAndCityRow()
                
                CurrentTemperatureRow()
                
                HourlyForecastView(hourWeatherList: hourWeatherData)
                
                Spacer()
                
                CurrentWeatherDetailsView()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
//        .background(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
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

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

