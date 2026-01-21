//
//  MainCoordinatorView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

struct MainCoordinatorView: View {

    @StateObject var coordinator: MainCoordinator
    let authManager: AuthManager

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {

            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun")
                }
                .tag(MainCoordinator.Tab.weather)

            CitySearchView(authManager: authManager)
                .tabItem {
                    Label("Cities", systemImage: "building.2")
                }
                .tag(MainCoordinator.Tab.cities)

            SettingsView(authActionProviding: authManager)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(MainCoordinator.Tab.settings)
        }
    }
}
