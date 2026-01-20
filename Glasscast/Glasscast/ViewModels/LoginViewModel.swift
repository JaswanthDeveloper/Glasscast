//
//  LoginViewModel.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

@MainActor
final class LoginViewModel: ObservableObject {

    @Published var email = ""
    @Published var password = ""

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let authManager: AuthProviding
    private weak var coordinator: AuthCoordinating?

    init(
        authManager: AuthProviding,
        coordinator: AuthCoordinating
    ) {
        self.authManager = authManager
        self.coordinator = coordinator
    }

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Email and password are required"
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await authManager.signIn(
                    email: email,
                    password: password
                )
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }

    func signupTapped() {
        coordinator?.showSignup()
    }
}
