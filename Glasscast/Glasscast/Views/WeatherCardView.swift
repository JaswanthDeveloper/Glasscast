//
//  WeatherCardView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI

struct WeatherCardView: View {
    
    @EnvironmentObject var temperatureManager: TemperatureManager
    let forecast: WeatherForecast

    var body: some View {
        HStack(spacing: 16) {

            Image(forecast.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)

            VStack(alignment: .leading, spacing: 6) {
                Text(formattedDate)
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(forecast.description.capitalized)
                    .font(.headline)

                Text("\(temperatureManager.format(forecast.minTemperature)) - \(temperatureManager.format(forecast.maxTemperature))")
                    .font(.title3)
                    .bold()
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.blue.opacity(0.3))
        .cornerRadius(16)
    }

    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM"
        return formatter.string(from: forecast.date)
    }
}
