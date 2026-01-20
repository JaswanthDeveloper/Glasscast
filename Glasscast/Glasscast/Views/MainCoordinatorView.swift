//
//  MainCoordinatorView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

struct MainCoordinatorView: View {

    @StateObject var coordinator: MainCoordinator

    var body: some View {
        TabView(selection: $coordinator.selectedTab) {

            WeatherView()
                .tabItem {
                    Label("Weather", systemImage: "cloud.sun")
                }
                .tag(MainCoordinator.Tab.weather)

            CitySearchView()
                .tabItem {
                    Label("Cities", systemImage: "building.2")
                }
                .tag(MainCoordinator.Tab.cities)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag(MainCoordinator.Tab.settings)
        }
    }
}

struct SettingsView: View {
    var body: some View {
        Text("Settings Screen")
    }
}
