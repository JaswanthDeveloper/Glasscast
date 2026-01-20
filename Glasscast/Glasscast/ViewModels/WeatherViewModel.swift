//
//  WeatherViewModel.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
import Combine

@MainActor
final class WeatherViewModel: ObservableObject {

    @Published var forecasts: [WeatherForecast] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let getForecastUseCase: GetWeatherForecastUseCase
    private var loadTask: Task<Void, Never>?

    init(getForecastUseCase: GetWeatherForecastUseCase) {
        self.getForecastUseCase = getForecastUseCase
    }

    func loadWeather() {
        loadTask?.cancel()

        loadTask = Task {
            isLoading = true
            defer { isLoading = false }

            do {
                let data = try await getForecastUseCase.execute(
                    lat: 12.97,
                    lon: 77.59
                )
                forecasts = data
                print("\n Data Received: \(forecasts.count)")
            } catch is CancellationError {
                // ignore
            } catch {
                errorMessage = error.localizedDescription
                print("\n errorMessage: \(errorMessage ?? "")")
            }   
        }
    }

    func refresh() {
        forecasts = []
        errorMessage = nil
        loadWeather()
    }
}
