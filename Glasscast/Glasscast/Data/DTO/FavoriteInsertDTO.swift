//
//  FavoriteInsertDTO.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 21/01/26.
//

import Foundation

struct FavoriteInsertDTO: Codable {
    let id: Int
    let user_id: UUID
    let city_name: String
    let country: String
    let lat: Double
    let lon: Double
}

extension FavoriteInsertDTO {
    func toDomain() -> CityWeather {
        CityWeather(id: id,
                    cityName: city_name,
                    condition: "",
                    temperature: 0,
                    country: country,
                    iconName: "01d",
                    time: "",
                    lat: lat,
                    lon: lon
        )
    }
}
