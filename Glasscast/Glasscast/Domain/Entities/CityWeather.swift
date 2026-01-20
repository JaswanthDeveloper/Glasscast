//
//  CityWeather.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
import Foundation

struct CityWeather: Identifiable {
    let id: Int
    let cityName: String
    let condition: String
    let temperature: Double
    let country: String
    let iconName: String
    let time: String

    var formattedMeta: String {
        "\(country) · \(time) · \(Int(temperature))°C · \(condition)"
    }
}
