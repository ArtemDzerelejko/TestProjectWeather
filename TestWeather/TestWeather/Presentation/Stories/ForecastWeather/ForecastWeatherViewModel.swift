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
    
    let systemImagesForHourlyForecastView = ["cloud.sun", "sun.max", "moon", "cloud.rain", "cloud.bolt"]
    let labelsTexts = ["Зараз", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]
    let systemImagesForForecastWeatherCustomCell = ["cloud.sun", "sun.max", "moon", "cloud.rain", "cloud.bolt"]
    static let locationCity = Strings.odessa
    static let temperature = "4°"
    static let weather = Strings.cloudy
    let country: String
    static let time = "14:33"
    static let higher = "8°"
    static let lower = "5°"
    
    init(country: String) {
        self.country = country
    }
    
    func getForecastWeather() {
        weatherUseCase.creatingRequestToTheServerToGetForecastWeather(country: country) { [weak self] result in
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
