//
//  ViewModel.swift
//  TestWeather
//
//  Created by artem on 15.10.2023.
//

import Foundation

final class CurrentWeatherViewModel {
    
    private let weatherUseCase = WeatherUseCase()
    var onWeatherUpdate: ((ModelForCurrentWeather) -> Void)?
    var onError: ((Error) -> Void)?
    
    func getWeather() {
        weatherUseCase.creatingRequestToTheServerToGetWeather { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let modelForWeather):
                    self.onWeatherUpdate?(modelForWeather)
                case .failure(let error):
                    self.onError?(error)
                }
            }
        }
    }
}
