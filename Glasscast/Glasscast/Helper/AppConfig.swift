//
//  AppConfig.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//
import Foundation

enum AppConfig {

    static let weatherAPIKey: String = {
        guard let key = Bundle.main.object(
            forInfoDictionaryKey: "WEATHER_API_KEY"
        ) as? String, !key.isEmpty else {
            fatalError("WEATHER_API_KEY is missing. Check Info.plist and xcconfig.")
        }
        return key
    }()
}
