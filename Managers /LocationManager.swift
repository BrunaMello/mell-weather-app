//
//  LocationManager.swift
//  mell weather app
//
//  Created by Bruna Mello on 27/05/2023.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var currentLocation: CLLocation?
    private let locationManager = CLLocationManager()
    
    @Published var isLoading = false
    @Published var cityName = "Dublin 6"
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last, currentLocation == nil else { return }
        
        DispatchQueue.main.async {
            self.currentLocation = location
            self.isLoading = false
        }
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if error == nil {
                if let firstlocation = placemarks?[0],
                   let cityName = firstlocation.locality {
                    self?.cityName = cityName
                    self?.locationManager.stopUpdatingLocation()
                }
            }
        }
    }
}
