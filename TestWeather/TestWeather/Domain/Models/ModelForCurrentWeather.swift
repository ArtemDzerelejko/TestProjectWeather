//
//  ModelForCurrentJSON.swift
//  TestWeather
//
//  Created by artem on 15.10.2023.
//

import Foundation

struct ModelForCurrentWeather: Codable {
    let location: Location?
    let current: Current?
}

struct LocationOblect {
    let name: String?
    let region: String?
    let country: String?
    let lat: Double?
    let lon: Double?
    let localtime: String?
}

struct CurrentObject {
    let lastUpdatedEpoch: Int?
    let lastUpdated: String?
    let tempCelsius: Double?
    let tempFahrenheit: Double?
    let cloud: Int?
    let feelslikeCelsius: Double?
    let feelslikeFahrenheit: Double?
}
