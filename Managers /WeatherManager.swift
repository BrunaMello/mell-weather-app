//
//  WeatherManager.swift
//  mell weather app
//
//  Created by Bruna Mello on 27/05/2023.
//

import Foundation
import WeatherKit
import CoreLocation

//let weatherService = WeatherService()

@MainActor
class WeatherManager: ObservableObject {
    
    static let shared = WeatherManager()
    
    private let service = WeatherService.shared
    
    @discardableResult
    func weather(for location: Location) async -> CurrentWeather? {
        let currentWeather = await Task.detached(priority: .userInitiated) {
            let forcast = try? await self.service.weather(for: location.location, including: .current)
            return forcast
        }.value
//        _currentWeathers[location.id] = currentWeather
        return currentWeather
    }
}
