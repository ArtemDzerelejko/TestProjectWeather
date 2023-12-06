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
