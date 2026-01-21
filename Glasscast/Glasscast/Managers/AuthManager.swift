//
//  AuthManager.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Supabase
import Combine
import Foundation

@MainActor
final class AuthManager: ObservableObject, AuthProviding {

    @Published private(set) var isAuthenticated: Bool = false
    private(set) var session: Session?

    private let supabase: SupabaseClient
    private var authTask: Task<Void, Never>?

    init(supabaseProvider: SupabaseClientProviding) {
        self.supabase = supabaseProvider.client
        restoreSession()
        observeAuthChanges()
    }

    var currentUserId: UUID? {
        get async {
            try? await supabase.auth.session.user.id
        }
    }
    
    private func restoreSession() {
        Task { @MainActor in
            do {
                let session = try await supabase.auth.session
                self.session = session
                self.isAuthenticated = true
            } catch {
                self.session = nil
                self.isAuthenticated = false
            }
        }
    }

    private func observeAuthChanges() {
        authTask = Task { @MainActor in
            for await change in await supabase.auth.authStateChanges {
                switch change.event {
                case .signedIn, .tokenRefreshed:
                    session = change.session
                    isAuthenticated = true

                case .signedOut:
                    session = nil
                    isAuthenticated = false

                default:
                    break
                }
            }
        }
    }

    func signIn(email: String, password: String) async throws {
        let response = try await supabase.auth.signIn(
            email: email,
            password: password
        )
        session = response
        isAuthenticated = true
    }

    func signUp(email: String, password: String) async throws {
        let _ = try await supabase.auth.signUp(
            email: email,
            password: password
        )
       /*
        // Dont take inside the app -> Email verification is pending
        
        session = response.session
        isAuthenticated = true
        */
    }
    
    func signOut() async throws {
        try await supabase.auth.signOut()
        session = nil
        isAuthenticated = false
    }

    deinit {
        authTask?.cancel()
    }
}

extension AuthManager: FavoritesProviding {

    func fetchFavorites(userId: UUID) async throws -> [CityWeather] {
        let response: [FavoriteInsertDTO] = try await supabase.database
                .from("favorite_cities")
                .select()
                .eq("user_id", value: userId)
                .execute()
                .value

            return response.map { $0.toDomain() }
        }
    
        func addFavorite(city: CityWeather, userId: UUID) async throws {
            try await supabase.database
                .from("favorite_cities")
                .insert( FavoriteInsertDTO(
                    id: city.id,
                    user_id: userId,
                    city_name: city.cityName,
                    country: city.country,
                    lat: city.lat,
                    lon: city.lon
                ))
                .execute()
        }

    func removeFavorite(cityId: Int, userId: UUID) async throws {
            try await supabase.database
                .from("favorite_cities")
                .delete()
                .eq("user_id", value: userId)
                .eq("id", value: cityId)
                .execute()
        }
    
}
