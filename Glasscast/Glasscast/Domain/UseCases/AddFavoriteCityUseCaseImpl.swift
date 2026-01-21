//
//  AddFavoriteCityUseCaseImpl.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//

protocol AddFavoriteCityUseCase {
    func execute(city: CityWeather) async throws
}

final class AddFavoriteCityUseCaseImpl: AddFavoriteCityUseCase {

    private let authProvider: AuthProviding
    private let favoritesProvider: FavoritesProviding

    init(
        authProvider: AuthProviding,
        favoritesProvider: FavoritesProviding
    ) {
        self.authProvider = authProvider
        self.favoritesProvider = favoritesProvider
    }

    func execute(city: CityWeather) async throws {
        guard let userId = await authProvider.currentUserId else {
            throw AuthError.notAuthenticated
        }

        try await favoritesProvider.addFavorite(
            city: city,
            userId: userId
        )
    }
}
