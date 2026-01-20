//
//  SignupView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

struct SignupView: View {

    @StateObject var viewModel: SignupViewModel

    private let accentColor = Color(red: 0.82, green: 0.80, blue: 0.36)
    private let backgroundColor = Color(red: 0.98, green: 0.98, blue: 0.95)

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {

            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(.black)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Create Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Join us to get started.")
                    .foregroundColor(accentColor)
            }

            VStack(spacing: 20) {

                InputField(
                    title: "Email",
                    placeholder: "Enter your email",
                    text: $viewModel.email,
                    isSecure: false,
                    accentColor: accentColor
                )

                PasswordField(
                    title: "Password",
                    placeholder: "Create a password",
                    text: $viewModel.password,
                    isVisible: $viewModel.isPasswordVisible,
                    accentColor: accentColor
                )

                PasswordField(
                    title: "Confirm Password",
                    placeholder: "Confirm your password",
                    text: $viewModel.confirmPassword,
                    isVisible: $viewModel.isConfirmPasswordVisible,
                    accentColor: accentColor
                )
            }

            HStack(spacing: 12) {
                Button(action: viewModel.toggleTermsAgreement) {
                    Circle()
                        .strokeBorder(accentColor, lineWidth: 2)
                        .background(
                            Circle()
                                .fill(viewModel.agreedToTerms ? accentColor : .clear)
                        )
                        .frame(width: 22, height: 22)
                }

                Text("I agree to the ")
                + Text("Terms & Conditions")
                    .underline()
                    .fontWeight(.semibold)
            }
            .font(.subheadline)

            Spacer()

            Button {
                Task {
                    viewModel.signup()
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(30)
            }
            .disabled(!viewModel.isSignupEnabled)
            .opacity(viewModel.isSignupEnabled ? 1 : 0.5)
            .shadow(radius: 5)

            HStack {
                Spacer()

                Text("Already have an account? ")

                Button {
                    viewModel.goToLogin()
                } label: {
                    Text("Log In")
                        .fontWeight(.bold)
                        .foregroundColor(.yellow)
                }
                .buttonStyle(.plain)
                Spacer()
            }
            .font(.subheadline)
        }
        .padding()
        .background(backgroundColor.ignoresSafeArea())
    }
}

struct InputField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    let isSecure: Bool
    let accentColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.medium)

            TextField(placeholder, text: $text)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(accentColor, lineWidth: 1)
                )
        }
    }
}

struct PasswordField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    @Binding var isVisible: Bool
    let accentColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.medium)

            HStack {
                Group {
                    if isVisible {
                        TextField(placeholder, text: $text)
                    } else {
                        SecureField(placeholder, text: $text)
                    }
                }

                Button(action: {
                    isVisible.toggle()
                }) {
                    Image(systemName: isVisible ? "eye.slash" : "eye")
                        .foregroundColor(accentColor)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(accentColor, lineWidth: 1)
            )
        }
    }
}
