//
//  TimeInterval+App.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//
import Foundation

extension TimeInterval {
    func toDateString(
        format: String = "hh:mm a",
        timeZone: TimeZone = .current
    ) -> String {
        let date = Date(timeIntervalSince1970: self)
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = timeZone
        return formatter.string(from: date)
    }
}
