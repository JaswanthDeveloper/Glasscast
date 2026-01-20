//
//  AuthProviding.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Supabase

@MainActor
protocol AuthStateProviding {
    var isAuthenticated: Bool { get }
}

protocol AuthActionProviding {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut() async throws
    
}

typealias AuthProviding = AuthStateProviding & AuthActionProviding
