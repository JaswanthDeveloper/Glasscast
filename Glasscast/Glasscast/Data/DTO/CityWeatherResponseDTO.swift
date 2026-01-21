//
//  CityWeatherResponseDTO.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import Foundation

struct CityWeatherResponseDTO: Decodable {
    let coord: CoordDTO
    let weather: [WeatherDTO]
    let base: String
    let main: MainDTO
    let visibility: Int
    let wind: WindDTO
    let clouds: CloudsDTO
    let dt: TimeInterval
    let sys: SysDTO
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
}

extension CityWeatherResponseDTO {
    func toDomain() -> CityWeather {
        CityWeather(id: id,
                    cityName: name,
                    condition: weather.first?.description ?? "",
                    temperature: main.temp,
                    country: sys.country ?? "",
                    iconName: weather.first?.icon ?? "",
                    time: dt.toDateString(),
                    lat: coord.lat,
                    lon: coord.lon)
    }
}
