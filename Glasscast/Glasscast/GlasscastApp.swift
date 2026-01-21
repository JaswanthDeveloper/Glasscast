//
//  GlasscastApp.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 17/01/26.
//

import SwiftUI

@main
struct GlasscastApp: App {
    @StateObject private var appCoordinator: AppCoordinator
    @StateObject private var temperatureManager = TemperatureManager()

       init() {
           let supabaseManager = SupabaseManager()
           let authManager = AuthManager(supabaseProvider: supabaseManager)
           _appCoordinator = StateObject(
               wrappedValue: AppCoordinator(authManager: authManager)
           )
       }

       var body: some Scene {
           WindowGroup {
               appCoordinator.start()
                   .environmentObject(temperatureManager)
           }
       }
}
