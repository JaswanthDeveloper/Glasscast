//
//  SettingsView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 22/01/26.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var temperatureManager: TemperatureManager

    let authActionProviding: AuthActionProviding
    
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            VStack(spacing: 24) {
                
                // Title
                TitleCard(title: "Settings")
                
                // Temperature Unit Card
                TemperatureUnitCard(isFahrenheit: $temperatureManager.isFahrenheit)
                
                Spacer()
                
                // Sign Out Button
                SignOutButton(onTap: {
                    Task {
                        do {
                            try await authActionProviding.signOut()
                        } catch {
                            // Handle error (log, alert, toast, etc.)
                            print("Sign out failed:", error.localizedDescription)
                        }
                    }
                })
                
                // App Version
                Text("V2.4.0")
                    .font(.footnote)
                    .foregroundColor(.white.opacity(0.4))
                    .padding(.bottom, 24)
            }
            .padding()
        }
    }
}

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [
                Color.black,
                Color.black.opacity(0.9),
                Color.black.opacity(0.85)
            ],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

struct TitleCard: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(GlassCard())
    }
}


struct TemperatureUnitCard: View {
    
    @Binding var isFahrenheit: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            
            // Icon
            ZStack {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(0.1))
                    .frame(width: 50, height: 50)
                
                Image(systemName: "thermometer")
                    .foregroundColor(.cyan)
                    .font(.title2)
            }
            
            // Text
            VStack(alignment: .leading, spacing: 6) {
                Text("Temperature Unit")
                    .foregroundColor(.white)
                    .font(.headline)
                
                Text("Celsius or Fahrenheit")
                    .foregroundColor(.white.opacity(0.6))
                    .font(.subheadline)
            }
            
            Spacer()
            
            // Toggle
            HStack(spacing: 6) {
                Text("°C")
                    .foregroundColor(.white.opacity(!isFahrenheit ? 1 : 0.4))
                
                Toggle("", isOn: $isFahrenheit)
                    .labelsHidden()
                    .tint(.cyan)
                
                Text("°F")
                    .foregroundColor(.white.opacity(isFahrenheit ? 1 : 0.4))
            }
        }
        .padding()
        .background(GlassCard())
    }
}

struct SignOutButton: View {
    
    let onTap: () -> Void
    
    var body: some View {
        Button {
            // sign out action
            onTap()
        } label: {
            HStack(spacing: 12) {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Sign Out")
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(GlassCard())
        }
    }
}

struct GlassCard: View {
    
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(
                Color.white.opacity(0.08)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1)
            )
            .background(
                RoundedRectangle(cornerRadius: 30)
                    .fill(Color.black.opacity(0.4))
            )
    }
}
