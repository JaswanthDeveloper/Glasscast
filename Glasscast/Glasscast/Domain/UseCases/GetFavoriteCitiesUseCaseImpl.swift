//
//  GetFavoriteCitiesUseCaseImpl.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//

protocol GetFavoriteCitiesUseCase {
    func execute() async throws -> [CityWeather]
}

final class GetFavoriteCitiesUseCaseImpl: GetFavoriteCitiesUseCase {

    private let authProvider: AuthProviding
    private let favoritesProvider: FavoritesProviding

    init(
        authProvider: AuthProviding,
        favoritesProvider: FavoritesProviding
    ) {
        self.authProvider = authProvider
        self.favoritesProvider = favoritesProvider
    }

    func execute() async throws -> [CityWeather] {
        guard let userId = await authProvider.currentUserId else {
            throw AuthError.notAuthenticated
        }

        return try await favoritesProvider.fetchFavorites(userId: userId)
    }
}

