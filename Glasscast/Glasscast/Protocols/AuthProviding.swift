//
//  AuthProviding.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Supabase
import Foundation

@MainActor
protocol AuthStateProviding {
    var isAuthenticated: Bool { get }
    var currentUserId: UUID? { get async }
}

protocol AuthActionProviding {
    func signIn(email: String, password: String) async throws
    func signUp(email: String, password: String) async throws
    func signOut() async throws
    
}

typealias AuthProviding = AuthStateProviding & AuthActionProviding
