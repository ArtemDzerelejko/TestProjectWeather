//
//  ModelForForecastWeatherRemote.swift
//  TestWeather
//
//  Created by artem on 16.10.2023.
//

import Foundation

struct ModelForForecastWeatherRemote: Codable {
    let location: LocationForecast?
    let current: CurrentForecast?
    let forecast: WeatherForecast?
}

struct LocationForecast: Codable {
    let name: String?
    let region: String?
    let country: String?
    let localtime: String?
}

struct CurrentForecast: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempCelsius: Double?
    let cloud: Int?
    let feelslikeCelsius: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempCelsius = "temp_c"
        case cloud
        case feelslikeCelsius = "feelslike_c"
    }
}

struct WeatherForecast: Codable {
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
            
            enum CodingKeys: String, CodingKey {
                case maxtempCelsius = "maxtemp_c"
                case mintempCelsius = "mintemp_c"
                case maxwindMph = "maxwind_mph"
                case maxwindKph = "maxwind_kph"
                case dailyWillItRain = "daily_will_it_rain"
                case dailyChanceOfRain = "daily_chance_of_rain"
                case dailyWillItSnow = "daily_will_it_snow"
                case dailyChanceOfSnow = "daily_chance_of_snow"
            }
        }
        
        struct Astro: Codable {
            let sunrise: String?
            let sunset: String?
            let moonrise: String?
            let moonset: String?
            let moonPhase: String?
            
            enum CodingKeys: String, CodingKey {
                case sunrise
                case sunset
                case moonrise
                case moonset
                case moonPhase = "moon_phase"
            }
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
            
            enum CodingKeys: String, CodingKey {
                case tempCelsius = "temp_c"
                case windMph = "wind_mph"
                case windKph = "wind_kph"
                case windDegree = "wind_degree"
                case humidity
                case cloud
                case feelslikeCelsius = "feelslike_c"
                case willItRain = "will_it_rain"
                case chanceOfRain = "chance_of_rain"
                case willItSnow = "will_it_snow"
                case chanceOfSnow = "chance_of_snow"
            }
        }
        
        enum CodingKeys: String, CodingKey {
            case date
            case dateEpoch = "date_epoch"
            case day
            case astro
            case hour
        }
    }
}
