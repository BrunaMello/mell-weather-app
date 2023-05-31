//
//  DateAndCityRow.swift
//  mell weather app
//
//  Created by Bruna Mello on 30/05/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct DateAndCityRow: View {
    
    let weatherService = WeatherService.shared
    @StateObject private var locationManager = LocationManager()
    @State private var weather: Weather?
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            if locationManager.currentLocation != nil {
                Text("\(locationManager.cityName)")
                    .bold()
                    .font(.title)
            } else {
                Text("City Name")
                    .bold()
                    .font(.title)
            }
            Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                .fontWeight(.light)
        }
        .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct DateAndCityRow_Previews: PreviewProvider {
    static var previews: some View {
        DateAndCityRow()
    }
}
