//
//  GetWeatherForecastUseCase.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
protocol WeatherRepository {
    func fetchForecast(lat: Double, lon: Double) async throws -> [WeatherForecast]
}

final class GetWeatherForecastUseCase {
    private let repository: WeatherRepository

    init(repository: WeatherRepository) {
        self.repository = repository
    }

    func execute(lat: Double, lon: Double) async throws -> [WeatherForecast] {
        try await repository.fetchForecast(lat: lat, lon: lon)
    }
}
