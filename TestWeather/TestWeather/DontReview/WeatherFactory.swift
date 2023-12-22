//
//  WeatherFactory.swift
//  TestWeather
//
//  Created by artem on 08.12.2023.
//

import UIKit

protocol WeatherFectoryProtocol {
    static func getWeather(forCountry: String) -> ForecastWeatherViewController
}

final class WeatherFactory: WeatherFectoryProtocol {
    static func getWeather(forCountry: String) -> ForecastWeatherViewController {
        let viewModel: ForecastWeatherViewModel = .init(country: forCountry)
        let viewController = ForecastWeatherViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

final class FakeWeatherFactory: WeatherFectoryProtocol {
    static func getWeather(forCountry: String) -> ForecastWeatherViewController {
        let viewModel: ForecastWeatherViewModel = .init(country: forCountry)
        let viewController = ForecastWeatherViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}
