//
//  WeatherSearchAPIServiceImpl.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Foundation
import Combine

protocol WeatherAPI {
    func searchCityWeather(city: String) -> AnyPublisher<CityWeatherResponseDTO, Error>
}

final class WeatherAPIImpl: WeatherAPI {

    func searchCityWeather(city: String) -> AnyPublisher<CityWeatherResponseDTO, Error> {
        let url = URL(
            string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(AppConfig.weatherAPIKey)&units=metric"
        )!
        print("\nURL: \(url.absoluteString)")
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: CityWeatherResponseDTO.self, decoder: JSONDecoder())
            .mapError { error -> Error in
                    if let decodingError = error as? DecodingError {
                        Self.printDecodingError(decodingError)
                    } else {
                        print("❌ Network error:", error.localizedDescription)
                    }
                    return error
                }
            .eraseToAnyPublisher()
    }
    
    private static func printDecodingError(_ error: DecodingError) {
        switch error {
        case .keyNotFound(let key, let context):
            print("❌ Key '\(key)' not found:", context.debugDescription)
            print("CodingPath:", context.codingPath)

        case .typeMismatch(let type, let context):
            print("❌ Type mismatch:", type)
            print("CodingPath:", context.codingPath)
            print("Debug:", context.debugDescription)

        case .valueNotFound(let type, let context):
            print("❌ Value '\(type)' not found:", context.debugDescription)
            print("CodingPath:", context.codingPath)

        case .dataCorrupted(let context):
            print("❌ Data corrupted:", context.debugDescription)
            print("CodingPath:", context.codingPath)

        @unknown default:
            print("❌ Unknown decoding error")
        }
    }

}
