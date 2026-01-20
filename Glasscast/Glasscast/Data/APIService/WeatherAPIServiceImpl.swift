//
//  WeatherAPIServiceImpl.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Foundation

protocol WeatherAPIService {
    func fetchForecast(lat: Double, lon: Double) async throws -> ForecastResponseDTO
}

final class WeatherAPIServiceImpl: WeatherAPIService {

    func fetchForecast(lat: Double, lon: Double) async throws -> ForecastResponseDTO {
        let urlString =
        """
        https://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&exclude=minutely,hourly,weekly,alerts&appid=\(AppConfig.weatherAPIKey)
        """

        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(ForecastResponseDTO.self, from: data)
    }
}
