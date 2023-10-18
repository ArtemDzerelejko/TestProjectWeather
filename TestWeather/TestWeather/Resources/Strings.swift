//
//  Strings.swift
//  TestWeather
//
//  Created by artem on 17.10.2023.
//

import Foundation

enum Strings {
    // MARK: - MainViewController
    static let currentWeather: String = "currentWeather".localized
    static let forecastWeather: String = "forecastWeather".localized
    
    // MARK: - CurrentWeatherViewController
    static let country: String = "country".localized
    static let city: String = "city".localized
    static let dateAndTime: String = "dateAndTime".localized
    static let cloud: String = "cloud".localized
    static let tempCelsius: String = "tempCelsius".localized
    static let tempFahrenheit: String = "tempFahrenheit".localized
    static let feelsLike: String = "feelsLike".localized
    
    static let recommendationToMinusThirty: String = "recommendationToMinusThirty".localized
    static let recommendationToMinusNine: String = "recommendationToMinusNine"
    static let recommendationToPlusOne: String = "recommendationToPlusOne".localized
    static let recommendationToPlusEleven: String = "recommendationToPlusEleven".localized
    static let recommendationToPlusTwentyOne: String = "recommendationToPlusTwentyOne".localized
    static let recommendationToPlusThirtyOne: String = "recommendationToPlusThirtyOne".localized
    static let standardWeatherTips: String = "standardWeatherTips".localized
    
    // MARK: - ForecastWeatherViewController
    static let date: String = "date".localized
    static let maxTemperature: String = "maxTemperature".localized
    static let minTemperature: String = "minTemperature".localized
    static let chanceOfRain: String = "chanceOfRain".localized
    static let fetchingWeatherData: String = "fetchingWeatherData".localized
    
    
    // MARK: - image
    static let sunMaxFill: String = "sun.max.fill"
    static let arrowBackwardCircle: String = "arrow.backward.circle"
    static let cloudSunRainFill: String = "cloud.sun.rain.fill"
    static let cloudFill: String = "cloud.fill"
    static let smokeFill: String = "smoke.fill"
    static let clockArrow: String = "clock.arrow.2.circlepath"
    
    // MARK: - Error
    static let error: String = "error"
    static let ok: String = "ok"
}
