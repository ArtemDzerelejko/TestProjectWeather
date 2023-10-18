//
//  ForecastWeatherViewModel.swift
//  TestWeather
//
//  Created by artem on 16.10.2023.
//

import Foundation

final class ForecastWeatherViewModel {
    
    private let weatherUseCase = WeatherUseCase()
    var onWeatherUpdate: ((ModelForForecastWeather) -> Void)?
    var onError: ((Error) -> Void)?
    var weatherData: ModelForForecastWeather?
    
    func getForecastWeather() {
        weatherUseCase.creatingRequestToTheServerToGetForecastWeather { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let modelForForecastWeather):
                    self.onWeatherUpdate?(modelForForecastWeather)
                case .failure(let error):
                    self.onError?(error)
                }
            }
        }
    }
}
