//
//  WeatherResultView.swift
//  Glasscast
//
//  Created by Jaswanth Pereira on 20/01/26.
//

import SwiftUI


struct WeatherResultView: View {
    
    let weather: CityWeather
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            
            VStack(alignment: .leading, spacing: 6) {
                
                Text(weather.cityName)
                    .font(.headline)
                
                Text(weather.condition)
                    .foregroundColor(.olive)
                
                HStack(spacing: 6) {
                    Text(weather.formattedMeta)
                        .font(.subheadline)
                        .foregroundColor(.olive)
                    
                    Image(weather.iconName)
                        .renderingMode(.template)
                        .foregroundColor(.olive)
                }
            }
            
            Spacer()
            
            Image(systemName: "star")
                .font(.title3)
        }
    }
}
