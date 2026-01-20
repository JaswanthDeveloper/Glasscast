//
//  SignupViewModel.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class SignupViewModel: ObservableObject {

    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    @Published var isPasswordVisible: Bool = false
    @Published var isConfirmPasswordVisible: Bool = false
    @Published var agreedToTerms: Bool = false
    @Published var isLoading: Bool = false
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

    var isSignupEnabled: Bool {
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword &&
        agreedToTerms &&
        !isLoading
    }

    func togglePasswordVisibility() {
        isPasswordVisible.toggle()
    }

    func toggleConfirmPasswordVisibility() {
        isConfirmPasswordVisible.toggle()
    }

    func toggleTermsAgreement() {
        agreedToTerms.toggle()
    }

    func signup() {
        guard isSignupEnabled else { return }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                try await authManager.signUp(
                    email: email,
                    password: password
                )
            } catch {
                errorMessage = error.localizedDescription
            }

            isLoading = false
        }
    }

    func goToLogin() {
        coordinator?.showLogin()
    }
}
