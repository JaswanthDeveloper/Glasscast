//
//  AuthCoordinator.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
import Combine
import SwiftUI


@MainActor
final class AuthCoordinator: ObservableObject, AuthCoordinating {

    enum Route: Hashable {
        case signup
    }

    @Published var path = NavigationPath()

    private let authProvider: AuthProviding

    init(authProvider: AuthProviding) {
        self.authProvider = authProvider
    }

    func showSignup() {
        path.append(Route.signup)
    }

    func showLogin() {
        path = NavigationPath()
    }
}
