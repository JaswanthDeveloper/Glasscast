//
//  TemperatureManager.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 22/01/26.
//

import SwiftUI
import Combine

final class TemperatureManager: ObservableObject {
    @AppStorage("isFahrenheit") var isFahrenheit: Bool = false
    
    /// Format Celsius temperature based on current unit
    func format(_ celsius: Double) -> String {
        if isFahrenheit {
            let fahrenheit = (celsius * 9/5) + 32
            return String(format: "%.1f °F", fahrenheit)
        } else {
            return String(format: "%.1f °C", celsius)
        }
    }
    
    /// Get numeric value in the preferred unit
    func value(_ celsius: Double) -> Double {
        isFahrenheit ? (celsius * 9/5) + 32 : celsius
    }
}
