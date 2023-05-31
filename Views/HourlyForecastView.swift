//
//  HourlyForecastView.swift
//  mell weather app
//
//  Created by Bruna Mello on 29/05/2023.
//

import SwiftUI
import WeatherKit

struct HourlyForecastView: View {
    
    @State private var weather: Weather?
    
    let hourWeatherList: [HourWeather]
    
    var body: some View {
        VStack {
            Text("HOURLY FORECAST")
                .font(.headline)
                .opacity(0.5)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(hourWeatherList, id: \.date) { hourWeatherItem in
                        VStack(spacing: 20) {
                            Text(hourWeatherItem.date.formatted(date: .omitted, time: .shortened))
                            Image(systemName: "\(hourWeatherItem.symbolName).fill")
                                .foregroundColor(.yellow)
                            Text(hourWeatherItem.temperature.formatted())
                                .fontWeight(.medium)
                        }
                        .padding()
                        .background {Color.gray}
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    }
                }
            }
        }.frame(maxWidth: .infinity, alignment: .center)
    }
}
