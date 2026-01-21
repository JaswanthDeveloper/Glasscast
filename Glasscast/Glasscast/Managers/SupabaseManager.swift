//
//  SupabaseManager.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Supabase
import Foundation

protocol SupabaseClientProviding {
    var client: SupabaseClient { get }
}

final class SupabaseManager: SupabaseClientProviding {

    let client: SupabaseClient

    init() {
        var components = URLComponents()
        components.scheme = Bundle.main.object(
            forInfoDictionaryKey: "API_SCHEME"
        ) as? String

        components.host = Bundle.main.object(
            forInfoDictionaryKey: "API_HOST"
        ) as? String

        guard let _ = components.url else {
            fatalError("Invalid API base URL")
        }
        
        self.client =  SupabaseClient(
            supabaseURL: SupabaseManager.makeSupabaseURL(),
            supabaseKey: SupabaseManager.supabaseKey
        )
    }
    
    private static var supabaseKey: String {
        infoPlistValue(for: "SUPABASE_KEY")
    }
    
    private static func makeSupabaseURL() -> URL {
        let scheme = infoPlistValue(for: "SUPABASE_API_SCHEME")
        let host = infoPlistValue(for: "SUPABASE_API_HOST")
        
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        
        guard let url = components.url else {
            fatalError("❌ Invalid Supabase URL")
        }
        return url
    }
    
    private static func infoPlistValue(for key: String) -> String {
        guard let value = Bundle.main.object(
            forInfoDictionaryKey: key
        ) as? String else {
            fatalError("❌ Missing \(key) in Info.plist")
        }
        return value
    }
}
