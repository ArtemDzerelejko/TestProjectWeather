//
//  WeatherUseCase.swift
//  TestWeather
//
//  Created by artem on 15.10.2023.
//

import Foundation

final class WeatherUseCase {
    
    private let weatherRepository: WeatherRepositoryProtocol = WeatherRepository()
    
    func creatingRequestToTheServerToGetWeather(completion: @escaping (Result<ModelForCurrentWeather, Error>) -> Void) {
        weatherRepository.creatingRequestToTheServerToGetWeather(completion: completion)
    }
    
    func creatingRequestToTheServerToGetForecastWeather(country: String, completion: @escaping (Result<ModelForForecastWeather, Error>) -> Void) {
        weatherRepository.creatingRequestToTheServerToGetForecastWeather(country: country, completion: completion)
    }
}
