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

       init() {
           let supabaseManager = SupabaseManager()
           let authManager = AuthManager(supabaseProvider: supabaseManager)
           _appCoordinator = StateObject(
               wrappedValue: AppCoordinator(authProvider: authManager)
           )
       }

       var body: some Scene {
           WindowGroup {
               appCoordinator.start()
           }
       }
}
