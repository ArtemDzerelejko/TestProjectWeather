//
//  WeatherRepositoryProtocol.swift
//  TestWeather
//
//  Created by artem on 15.10.2023.
//

import Foundation

protocol WeatherRepositoryProtocol {
    func creatingRequestToTheServerToGetWeather(completion: @escaping (Result<ModelForCurrentWeather, Error>) -> Void)
    
    func creatingRequestToTheServerToGetForecastWeather(country: String, completion: @escaping (Result<ModelForForecastWeather, Error>) -> Void)
}
