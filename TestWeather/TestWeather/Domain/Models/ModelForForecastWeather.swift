//
//  ModelForForecastWeather.swift
//  TestWeather
//
//  Created by artem on 16.10.2023.
//

import Foundation

struct ModelForForecastWeather: Codable {
    let location: LocationForecast?
    let current: CurrentForecast?
    let forecast: WeatherForecast?
}

struct LocationForecastObject: Codable {
    let name: String?
    let region: String?
    let country: String?
    let localtime: String?
}

struct CurrentForecastObject: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempCelsius: Double?
    let cloud: Int?
    let feelslikeCelsius: Double?
}

struct WeatherForecastObject: Codable {
    let forecastday: [ForecastDay]?
    
    struct ForecastDay: Codable {
        let date: String?
        let dateEpoch: Int?
        let day: Day?
        let astro: Astro?
        let hour: [Hour]?
        
        struct Day: Codable {
            let maxtempCelsius: Double?
            let mintempCelsius: Double?
            let maxwindMph: Double?
            let maxwindKph: Double?
            let dailyWillItRain: Int?
            let dailyChanceOfRain: Int?
            let dailyWillItSnow: Int?
            let dailyChanceOfSnow: Int?
        }
        
        struct Astro: Codable {
            let sunrise: String?
            let sunset: String?
            let moonrise: String?
            let moonset: String?
            let moonPhase: String?
        }
        
        struct Hour: Codable {
            let tempCelsius: Double?
            let windMph: Double?
            let windKph: Double?
            let windDegree: Int?
            let humidity: Int?
            let cloud: Int?
            let feelslikeCelsius: Double?
            let willItRain: Int?
            let chanceOfRain: Int?
            let willItSnow: Int?
            let chanceOfSnow: Int?
        }
    }
}
