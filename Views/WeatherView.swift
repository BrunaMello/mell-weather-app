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
    
    
    var body: some View {
        ZStack(alignment: .leading){
            if let weather {
                VStack{
                    VStack(alignment: .leading, spacing: 5){
                        
                        if let location = locationManager.currentLocation {
                            Text("\(locationManager.cityName)")
                                .bold()
                                .font(.title)
                        }
                        
                        
                        Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                            .fontWeight(.light)
                    
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    VStack {
                        HStack{
                            VStack(spacing: 20) {
                                Image(systemName: "sun.max")
                                    .font(.system(size: 40))
                                
                                Text("Weather condition")
                            }
                            .frame(width: 150, alignment: .leading)
                            
                            Spacer()
                            
                            Text("\(weather.currentWeather.temperature.formatted())")
                                .font(.system(size: 70))
                                .fontWeight(.bold)
                                .padding()
                        }
                        
                        Spacer()
                            .frame(height: 80)
                        
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_1280.png")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350)
                        } placeholder: {
                            ProgressView()
                        }
                        
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
