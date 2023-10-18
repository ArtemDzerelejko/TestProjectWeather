//
//  ModelForCurrentJSONRemote.swift
//  TestWeather
//
//  Created by artem on 15.10.2023.
//

import Foundation

struct ModelForCurrentWeatherRemote: Codable {
    let location: Location?
    let current: Current?
}

struct Location: Codable {
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let localtime: String?
}

struct Current: Codable {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempCelsius: Double?
    let tempFahrenheit: Double?
    let cloud: Int?
    let feelslikeCelsius: Double?
    let feelslikeFahrenheit: Double?
    
    enum CodingKeys: String, CodingKey {
        case lastUpdatedEpoch = "last_updated_epoch"
        case lastUpdated = "last_updated"
        case tempCelsius = "temp_c"
        case tempFahrenheit = "temp_f"
        case cloud
        case feelslikeCelsius = "feelslike_c"
        case feelslikeFahrenheit = "feelslike_f"
    }
}
