//
//  AuthManager.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Supabase
import Combine

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
        let response = try await supabase.auth.signUp(
            email: email,
            password: password
        )
        session = response.session
        isAuthenticated = true
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
