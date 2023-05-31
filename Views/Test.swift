//
//  Test.swift
//  mell weather app
//
//  Created by Bruna Mello on 30/05/2023.
//

import SwiftUI
import WeatherKit
import CoreLocation

struct Test: View {
    
    
    
    var body: some View {
        VStack {
            if let weather {
                Text("\(weather.currentWeather.temperature.formatted())")
                    .font(.title)
            }
        }

        }
    }
}


struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
