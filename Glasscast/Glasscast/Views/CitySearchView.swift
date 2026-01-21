//
//  CitySearchView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
import SwiftUI

struct CitySearchView: View {

    @EnvironmentObject var temperatureManager: TemperatureManager
    @StateObject private var viewModel: CitySearchViewModel
    let authManager: AuthManager
   
    @StateObject private var cityListViewModel: CityListViewModel
    
    init(authManager: AuthManager) {
        let apiService = WeatherAPIImpl()
        let repository = SearchCityWeatherRepositoryImpl(api: apiService)
        let useCase = SearchCityWeatherUseCaseImpl(repository: repository)
        
        let cityListViewModel = CityListViewModel(addFavoriteUseCase: AddFavoriteCityUseCaseImpl(authProvider: authManager,
                                                                                                 favoritesProvider: authManager),
                                                  removeFavoriteCityUseCase: RemoveFavoriteCityUseCaseImpl(authProvider: authManager,
                                                                                                           favoritesProvider: authManager),
                                                  getFavoritesUseCase: GetFavoriteCitiesUseCaseImpl(authProvider: authManager,
                                                                                                    favoritesProvider: authManager))
        _cityListViewModel = StateObject(wrappedValue: cityListViewModel)
        _viewModel = StateObject(
            wrappedValue: CitySearchViewModel(
                searchCityWeatherUseCase: useCase,
                cityListViewModel: cityListViewModel
            )
        )
        self.authManager = authManager
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    SearchBar(text: $viewModel.searchText)

                    if viewModel.isLoading {
                        loadingView
                    } else if let weather = viewModel.cityWeather {
                        resultView(weather)
                    } else if viewModel.searchText.count >= 2 {
                        emptyStateView
                    }
                    if !cityListViewModel.favoriteCities.isEmpty {
                        FavoritesSectionView(
                            favoriteCities: cityListViewModel.favoriteCities,
                            onRemove: { city in
                                Task {
                                    cityListViewModel.removeFavorite(city: city)
                                }
                            }
                        )
                    }
                }
                .padding(.top)
                
            }
            .navigationTitle("Search City")
        }
        .onChange(of: viewModel.searchText, { oldValue, newValue in
            if newValue.isEmpty {
                viewModel.cityWeather = nil // Clear previous result
            }
        })
        .onAppear {
            Task {
                await cityListViewModel.loadFavorites()
            }
        }
    }
}

struct SearchBar: View {

    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.olive)

            TextField("Search city", text: $text)
                .textInputAutocapitalization(.words)
                .autocorrectionDisabled()

            if !text.isEmpty {
                Button {
                    text = ""
                    
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.olive)
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(14)
        .padding(.horizontal)
    }
}


private extension CitySearchView {

    func resultView(_ weather: CityWeather) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Search Result")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            WeatherResultView(weather: weather,
                              cityListViewModel: viewModel.cityListViewModel)
            .padding(.horizontal)
            
        }
    }
}

private extension CitySearchView {

    var loadingView: some View {
        HStack {
            Spacer()
            ProgressView("Searching…")
            Spacer()
        }
        .padding(.top, 40)
    }
}


private extension CitySearchView {

    var emptyStateView: some View {
        Text("No city found")
            .foregroundColor(.secondary)
            .padding(.horizontal)
            .padding(.top, 40)
    }
}
