//
//  AppCordinator.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
import SwiftUI
import Combine

@MainActor
final class AppCoordinator: ObservableObject, AppCoordinating {
    enum Flow {
        case auth
        case main
    }

    @Published private var flow: Flow = .auth

    private let authManager: AuthManager
    private var cancellables = Set<AnyCancellable>()

    init(authManager: AuthManager) {
        self.authManager = authManager
        observeAuthState()
    }

    func start() -> AnyView {
        switch flow {
        case .auth:
            return AnyView(
                AuthCoordinatorView(coordinator: AuthCoordinator(authProvider: self.authManager), authProvider: authManager)
            )

        case .main:
            return AnyView(
                MainCoordinatorView(
                    coordinator: MainCoordinator(),
                    authManager: authManager
                )
            )
        }
    }

    private func observeAuthState() {
        authManager
            .$isAuthenticated
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] isAuthenticated in
                self?.flow = isAuthenticated ? .main : .auth
            }
            .store(in: &cancellables)
    }
}
