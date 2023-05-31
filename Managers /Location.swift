//
//  Location.swift
//  mell weather app
//
//  Created by Bruna Mello on 30/05/2023.
//

import Foundation
import CoreLocation

struct Location: Hashable, Identifiable {
    var code: String
    var city: String
    var region: String
    var country: String
    var latitude: Double
    var longitude: Double
    
    var id: String { code }
    
    var location: CLLocation {
        CLLocation(latitude: latitude, longitude: longitude)
    }
    
}
