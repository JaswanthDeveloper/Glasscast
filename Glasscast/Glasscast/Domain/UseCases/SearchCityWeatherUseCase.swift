//
//  SearchCityWeatherUseCase.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Combine

protocol SearchCityWeatherUseCase {
    func searchCityWeather(city: String) -> AnyPublisher<CityWeather, Error>
}

final class SearchCityWeatherUseCaseImpl: SearchCityWeatherUseCase {

    private let repository: SearchCityWeatherRepository

    init(repository: SearchCityWeatherRepository) {
        self.repository = repository
    }

    func searchCityWeather(city: String) -> AnyPublisher<CityWeather, Error> {
        repository.searchCityWeather(city: city)
    }
}
