//
//  CurrentWeatherDetailsView.swift
//  mell weather app
//
//  Created by Bruna Mello on 30/05/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct CurrentWeatherDetailsView: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    
    @State private var weather: Weather?
    @State private var dayWeather: DayWeather?
    
    
    var body: some View {
        
        VStack {
            if let weather {
//                if let dayWeather {
                    VStack {
                        Text("Weather Now")
                            .bold()
                            .padding(.bottom)
                        
                        // temperature details
                        HStack {
                            //min
                            WeatherRow(logo: "thermometer", name: "Max Temp", value: "9º")
                            
                            Spacer()
                            
                            //max
                            WeatherRow(logo: "thermometer", name: "Max Temp", value: "9º")
                        }
                        
                        // wind and humidity details
                        HStack {
                            //min
                            WeatherRow(logo: "wind", name: "Wind", value: "\(Int((weather.currentWeather.wind.speed.value).rounded())) Km/h")
                            
                            Spacer()
                            
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(Int((weather.currentWeather.humidity * 100).rounded())) %")
                        }
                        
                    }
                    
                }
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            .foregroundColor(Color(.black))
            .background(.gray)
            .cornerRadius(20)
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

struct CurrentWeatherDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherDetailsView()
    }
}

