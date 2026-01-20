//
//  AuthCoordinating.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

@MainActor
protocol AuthCoordinating: AnyObject {
    func showSignup()
    func showLogin()
}
