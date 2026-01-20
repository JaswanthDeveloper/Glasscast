//
//  WeatherRepositoryImpl.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

final class WeatherRepositoryImpl: WeatherRepository {

    private let apiService: WeatherAPIService

    init(apiService: WeatherAPIService) {
        self.apiService = apiService
    }

    func fetchForecast(lat: Double, lon: Double) async throws -> [WeatherForecast] {
        let response = try await apiService.fetchForecast(lat: lat, lon: lon)
        return response.list.map { $0.toDomain() }
    }
}
