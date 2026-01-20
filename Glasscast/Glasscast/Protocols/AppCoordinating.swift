//
//  AppCoordinating.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

@MainActor
protocol AppCoordinating: AnyObject {
    func start() -> AnyView
    
}
