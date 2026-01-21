//
//  WeatherResultView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

struct WeatherResultView: View {
    
    @EnvironmentObject var temperatureManager: TemperatureManager
    let weather: CityWeather
    @ObservedObject var cityListViewModel: CityListViewModel
    
    var isFavorite: Bool {
        cityListViewModel.favoriteCities.contains { $0.id == weather.id }
    }
    
    var onFavoriteTapped: (() -> Void)?

    private var formattedMeta: String {
        let temp = temperatureManager.format(weather.temperature)
        return "\(weather.country) · \(weather.time) · \(temp) · \(weather.condition)"
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(weather.cityName)
                    .font(.headline)
                
                Text(weather.condition)
                    .foregroundColor(.olive)
                
                HStack(spacing: 6) {
                    Text(formattedMeta)
                        .font(.subheadline)
                        .foregroundColor(.olive)
                    
                    Image(weather.iconName)
                        .renderingMode(.template)
                        .foregroundColor(.olive)
                }
            }
            
            Spacer()
            
            Button {
                Task {
                    if isFavorite {
                        cityListViewModel.removeFavorite(city: weather)
                    } else {
                        cityListViewModel.addFavorite(city: weather)
                    }
                }
            } label: {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
        }
    }
}
