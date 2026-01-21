//
//  FavouriteSectionView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//
import SwiftUI

struct FavoritesSectionView: View {

    let favoriteCities: [CityWeather]
    let onRemove: (CityWeather) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Favorites")
                .font(.title3)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ForEach(favoriteCities) { city in
                FavoriteCityCard(weather: city,
                                 onRemove: {
                    onRemove(city)
                })
                .padding(.horizontal)
            }
        }
    }
}

struct FavoriteCityCard: View {

    let weather: CityWeather
    let onRemove: () -> Void

    var body: some View {
        HStack(alignment: .top) {

            VStack(alignment: .leading, spacing: 8) {
                Text(weather.cityName)
                    .font(.headline)
                    .fontWeight(.bold)

                Text(weather.country)
                    .font(.subheadline)
                    .foregroundColor(.olive)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 12) {

                Button {
                    onRemove()
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(.olive)
                }

                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.05),
                        radius: 10, x: 0, y: 4)
        )
    }
}

