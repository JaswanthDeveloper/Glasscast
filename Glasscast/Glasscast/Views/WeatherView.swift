//
//  WeatherView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
import SwiftUI

struct WeatherView: View {

    @StateObject private var viewModel: WeatherViewModel

    init() {
        let apiService = WeatherAPIServiceImpl()
        let repository = WeatherRepositoryImpl(apiService: apiService)
        let useCase = GetWeatherForecastUseCase(repository: repository)
        _viewModel = StateObject(
            wrappedValue: WeatherViewModel(getForecastUseCase: useCase)
        )
    }

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(viewModel.forecasts, id: \.date) { forecast in
                    WeatherCardView(forecast: forecast)
                }
            }
            .padding()
        }
        .task {
            viewModel.loadWeather()
        }
        .refreshable {
            viewModel.refresh()
        }
    }
}
