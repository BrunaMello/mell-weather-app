//
//  TenDaysForecastView.swift
//  mell weather app
//
//  Created by Bruna Mello on 31/05/2023.
//

import SwiftUI
import WeatherKit

struct TenDaysForecastView: View {
    
    let dayWeatherList: [DayWeather]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("10-DAY FORCAST")
                .font(.headline)
                .opacity(0.5)
                .frame(maxWidth: .infinity)
            
            List(dayWeatherList, id: \.date) { dailyWeatherItem in
                HStack {
                    Text("\(dailyWeatherItem.date.formatAsAbbreviatedDay())")
                        .frame(maxWidth: 50, alignment: .leading)
                    Image(systemName: "\(dailyWeatherItem.symbolName).fill")
                        .foregroundColor(.yellow)
                    
                    Text("\(dailyWeatherItem.lowTemperature.formatted())")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Text("\(dailyWeatherItem.highTemperature.formatted())")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                
            }.listStyle(.plain)
        }.padding()
    }
}
