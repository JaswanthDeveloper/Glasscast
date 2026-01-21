//
//  AuthError.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//

import Foundation

enum AuthError: Error, LocalizedError {
    case notAuthenticated

    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated."
        }
    }
}
