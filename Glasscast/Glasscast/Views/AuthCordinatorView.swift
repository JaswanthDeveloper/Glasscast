//
//  AuthCordinatorView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//
import SwiftUI

struct AuthCoordinatorView: View {

    @StateObject var coordinator: AuthCoordinator
    let authProvider: AuthProviding

    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            LoginView(
                viewModel: LoginViewModel(authManager: authProvider,
                                          coordinator: coordinator)
            )
            .navigationDestination(for: AuthCoordinator.Route.self) { route in
                switch route {
                case .signup:
                    SignupView(
                        viewModel: SignupViewModel(authManager: authProvider,
                                                   coordinator: coordinator)
                    )
                }
            }
        }
    }
}
