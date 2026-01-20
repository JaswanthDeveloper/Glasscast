//
//  CitySearchViewModel.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI
import Combine

@MainActor
final class CitySearchViewModel: ObservableObject {

    @Published var searchText = ""
    @Published var cityWeather: CityWeather?
    @Published var isLoading = false

    private let searchCityWeatherUseCase: SearchCityWeatherUseCase
    private var cancellables = Set<AnyCancellable>()

    init(searchCityWeatherUseCase: SearchCityWeatherUseCase) {
        self.searchCityWeatherUseCase = searchCityWeatherUseCase
        bind()
    }

    private func bind() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .filter { $0.count >= 2 }
            .handleEvents(receiveOutput: { _ in
                self.isLoading = true
            })
            .flatMap { query in
                self.searchCityWeatherUseCase
                    .searchCityWeather(city: query)
                    .map(Optional.some)
                    .catch { _ in Just(nil) }
            }
            .receive(on: RunLoop.main)
            .sink { [weak self] weather in
                self?.cityWeather = weather
                self?.isLoading = false
            }
            .store(in: &cancellables)
    }
}
