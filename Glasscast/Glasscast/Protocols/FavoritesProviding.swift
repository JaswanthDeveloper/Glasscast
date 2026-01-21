//
//  FavoritesProviding.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//
import Foundation

protocol FavoritesProviding {
    func addFavorite(city: CityWeather, userId: UUID) async throws
    func removeFavorite(cityId: Int, userId: UUID) async throws
    func fetchFavorites(userId: UUID) async throws -> [CityWeather]
}
