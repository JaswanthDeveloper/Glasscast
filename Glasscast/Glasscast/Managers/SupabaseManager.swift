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
        self.client = SupabaseClient(
            supabaseURL: URL(string: "https://uexodxhmseixzdnqnyzh.supabase.co")!,
            supabaseKey: "sb_publishable_iduejdv5dlIME3632p12yw_OwPCqIBr"
        )
    }
}
