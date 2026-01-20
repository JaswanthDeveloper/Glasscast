//
//  MainCoordinator.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

@MainActor
final class MainCoordinator: ObservableObject {

    enum Tab {
        case weather
        case cities
        case settings
    }

    @Published var selectedTab: Tab = .weather

    func showWeather() {
        selectedTab = .weather
    }

    func showCities() {
        selectedTab = .cities
    }

    func showSettings() {
        selectedTab = .settings
    }
}

