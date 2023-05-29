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
            if let weather {
                VStack{
                    VStack(alignment: .center, spacing: 5){
                        
//                        if locationManager.currentLocation != nil {
//                            Text("\(locationManager.cityName)")
//                                .bold()
//                                .font(.title)
                            Text("\(locationManager.cityName)")
                                .bold()
                                .font(.title)
                        
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                    
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    VStack {
                        HStack(alignment: .center) {
                            VStack{
                                Image(systemName: "\(weather.currentWeather.symbolName)")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 60)
                                    .foregroundColor(.yellow)
                                Text("\(weather.currentWeather.condition.description)")
                                    .font(.subheadline)
                            }
                            .frame(width: 100, height: 200)
                            
                            Text("\(weather.currentWeather.temperature.formatted())")
                                .font(.system(size: 100))
                                .fontWeight(.bold)
                            
                        }
                        
                        HStack(alignment: .center, spacing: 50){

                            HourlyForecastView(hourWeatherList: hourWeatherData)
                        }
                        
                        Spacer()
                            .frame(height: 80)
                                                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Weather Now")
                            .bold()
                            .padding(.bottom)
                        
                        HStack{
                            //min temperature
                            WeatherRow(logo: "thermometer", name: "Min Temp", value: "9º")
                            Spacer()
                            
                            //max temperature
                            WeatherRow(logo: "thermometer", name: "Max Temp", value: "8º")
                        }
                        
                        HStack{
                            //wind speed
                            WeatherRow(logo: "wind", name: "Wind Speed", value: "\(weather.currentWeather.wind.speed.formatted())")
                            Spacer()
                            
                            //max temperature
                            WeatherRow(logo: "humidity", name: "Humidity", value: "\(weather.currentWeather.humidity * 100)%")
                        }
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .padding(.bottom, 20)
                    .foregroundColor(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
                    .background(.white)
                    .cornerRadius(20, corners: [.topLeft, .topRight])

                }
                
            }
            }
        .edgesIgnoringSafeArea(.bottom)
        .background(Color(hue: 0.655, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
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

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
