//
//  CityListViewModel.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//
import SwiftUI

@MainActor
class CityListViewModel: ObservableObject {

    @Published var favoriteCities: [CityWeather] = []

    private let addFavoriteUseCase: AddFavoriteCityUseCase
    private let removeFavoriteCityUseCase: RemoveFavoriteCityUseCase
    private let getFavoritesUseCase: GetFavoriteCitiesUseCase


    init(addFavoriteUseCase: AddFavoriteCityUseCase,
         removeFavoriteCityUseCase: RemoveFavoriteCityUseCase,
         getFavoritesUseCase: GetFavoriteCitiesUseCase) {
        self.addFavoriteUseCase = addFavoriteUseCase
        self.removeFavoriteCityUseCase = removeFavoriteCityUseCase
        self.getFavoritesUseCase = getFavoritesUseCase
    }

    func addFavorite(city: CityWeather) {
        Task {
            do {
                try await addFavoriteUseCase.execute(city: city)
                // Optionally update UI
                favoriteCities.append(city)
            } catch AuthError.notAuthenticated {
                print("User is not logged in!")
            } catch {
                print("Failed to add favorite: \(error)")
            }
        }
    }
    
    func removeFavorite(city: CityWeather) {
        Task {
            do {
                try await removeFavoriteCityUseCase.execute(city: city)
                favoriteCities.removeAll { $0.id == city.id }
            } catch AuthError.notAuthenticated {
                print("User is not logged in!")
            } catch {
                print("Failed to remove favorite: \(error)")
            }
        }
    }
    
    func loadFavorites() async {
            do {
                favoriteCities = try await getFavoritesUseCase.execute()
            } catch {
                print("Failed to load favorites:", error)
            }
        }
}
