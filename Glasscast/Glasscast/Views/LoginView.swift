//
//  LoginView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel: LoginViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 32) {
                Text("Welcome Back")
                    .font(.system(size: 28, weight: .bold, design: .default))
                    .foregroundColor(.primary)
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Email")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    TextField("", text: $viewModel.email, prompt: Text("Email").foregroundColor(.gray))
                        .font(.system(size: 17))
                        .foregroundColor(.primary)
                        .padding(16)
                        .background(Color(red: 1, green: 1, blue: 0.88)) // Matches screenshot's light yellow
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                    
                    Text("Password")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    SecureField("", text: $viewModel.password, prompt: Text("Password").foregroundColor(.gray))
                        .font(.system(size: 17))
                        .foregroundColor(.primary)
                        .padding(16)
                        .background(Color(red: 1, green: 1, blue: 0.88)) // Matches screenshot's light yellow
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                }
                
                Button("Login") {
                    viewModel.login()
                }
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color(red: 1, green: 0.8, blue: 0)) // Bright yellow
                .cornerRadius(16)
                
                HStack {
                    Text("Don't have an account?")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    Button("Sign up") {
                        viewModel.signupTapped()
                    }
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.blue)
                }
            }
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(UIColor.systemBackground))
            .navigationBarHidden(true)
            .ignoresSafeArea(.keyboard)
        }
    }
}
