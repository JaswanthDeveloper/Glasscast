//
//  WeatherSearchRepository.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Combine

protocol SearchCityWeatherRepository {
    func searchCityWeather(city: String) -> AnyPublisher<CityWeather, Error>
}

final class SearchCityWeatherRepositoryImpl: SearchCityWeatherRepository {

    private let api: WeatherAPI

    init(api: WeatherAPI) {
        self.api = api
    }

    func searchCityWeather(city: String) -> AnyPublisher<CityWeather, Error> {
        api.searchCityWeather(city: city)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
