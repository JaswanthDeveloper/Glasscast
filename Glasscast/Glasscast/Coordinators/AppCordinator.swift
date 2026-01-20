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

    private let authProvider: AuthProviding
    private var cancellables = Set<AnyCancellable>()

    init(authProvider: AuthProviding) {
        self.authProvider = authProvider
        observeAuthState()
    }

    func start() -> AnyView {
        switch flow {
        case .auth:
            return AnyView(
                AuthCoordinatorView(coordinator: AuthCoordinator(authProvider: self.authProvider), authProvider: authProvider)
            )

        case .main:
            return AnyView(
                MainCoordinatorView(
                    coordinator: MainCoordinator()
                )
            )
        }
    }

    private func observeAuthState() {
        (authProvider as? AuthManager)?
            .$isAuthenticated
            .removeDuplicates()
            .receive(on: RunLoop.main)
            .sink { [weak self] isAuthenticated in
                self?.flow = isAuthenticated ? .main : .auth
            }
            .store(in: &cancellables)
    }
}
