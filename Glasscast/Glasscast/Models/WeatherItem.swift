//
//  WeatherItem.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

// MARK: - Model
struct WeatherItem: Identifiable {
    let id = UUID()
    let city: String
    let temperature: Int
    let condition: String // e.g., "Sunny", "Rainy"
}
