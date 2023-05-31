//
//  DayWeatherManager.swift
//  mell weather app
//
//  Created by Bruna Mello on 31/05/2023.
//

import Foundation
import WeatherKit

class DayWeatherManager: NSObject, ObservableObject {
    
    @Published var dayweather: DayWeather?
    
    @Published var wind = Wind
    
    
    override init() {
        super.init()
        dayweather?.wind = self
        
    }
    
    
    
    
    
}
