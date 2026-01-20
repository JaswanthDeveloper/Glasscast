//
//  ForecastResponseDTO.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

struct ForecastResponseDTO: Decodable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [ForecastItemDTO]
    let city: CityDTO
}

struct ForecastItemDTO: Decodable {
    let dt: TimeInterval
    let main: MainDTO
    let weather: [WeatherDTO]
    let clouds: CloudsDTO
    let wind: WindDTO
    let visibility: Int
    let pop: Double
    let sys: SysDTO
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt
        case main
        case weather
        case clouds
        case wind
        case visibility
        case pop
        case sys
        case dtTxt = "dt_txt"
    }
}

struct MainDTO: Decodable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let seaLevel: Int?
    let grndLevel: Int?
    let humidity: Int
    let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct WeatherDTO: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CloudsDTO: Decodable {
    let all: Int
}

struct WindDTO: Decodable {
    let speed: Double
    let deg: Int
    let gust: Double?
}

struct SysDTO: Decodable {
    let pod: String?   // "d" or "n"
}

struct CityDTO: Decodable {
    let id: Int
    let name: String
    let coord: CoordDTO
    let country: String
    let population: Int
    let timezone: Int
    let sunrise: TimeInterval
    let sunset: TimeInterval
}

struct CoordDTO: Decodable {
    let lat: Double
    let lon: Double
}

extension ForecastItemDTO {
    func toDomain() -> WeatherForecast {
        WeatherForecast(
            date: Date(timeIntervalSince1970: dt),
            minTemperature: main.tempMin,
            maxTemperature: main.tempMax,
            description: weather.first?.description ?? "",
            icon: weather.first?.icon ?? ""
        )
    }
}
