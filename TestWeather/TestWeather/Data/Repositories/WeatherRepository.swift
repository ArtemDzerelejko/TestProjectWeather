//
//  WeatherRepository.swift
//  TestWeather
//
//  Created by artem on 15.10.2023.
//

import Foundation
import OSLog
let logger = Logger (subsystem: "testWeather", category: "Weather")

final class WeatherRepository: WeatherRepositoryProtocol {
    
    private let weatherAPIService = WeatherAPIService()
    private let userDefaults = UserDefaults.standard
    
    private enum Constans {
        static let lastSessionWeatherDataKey: String = "lastSessionWeatherData"
        static let lastSessionForecastWeatherDataKey: String = "lastSessionForecastWeatherData"
    }
    
    func creatingRequestToTheServerToGetWeather(completion: @escaping (Result<ModelForCurrentWeather, Error>) -> Void) {
        var isNeedUpdateData: Bool = true
        if let getWeatherData = getLastSessionWeatherData(type: ModelForCurrentWeatherRemote.self, forKey: Constans.lastSessionWeatherDataKey) {
            let adaptedData = ModelForCurrentWeather(location: getWeatherData.location, current: getWeatherData.current)
            isNeedUpdateData = false
            completion(.success(adaptedData))
        }
        
        weatherAPIService.fetchCurrentWeather { result in
            switch result {
            case .success(let weatherData):
                
                self.saveLastSessionWeatherData(weatherData, forKey: Constans.lastSessionWeatherDataKey)
                logger.log("Location: \(weatherData.location?.name ?? "Unknown")")
                logger.log("Temperature (Celsius): \(weatherData.current?.feelslikeCelsius ?? 0.0)")
                let adaptedData = ModelForCurrentWeather(location: weatherData.location, current: weatherData.current)
                if isNeedUpdateData {
                    completion(.success(adaptedData))
                }
            case .failure(let error):
                
                completion(.failure(error))
            }
        }
    }
    
    func creatingRequestToTheServerToGetForecastWeather(completion: @escaping (Result<ModelForForecastWeather, Error>) -> Void) {
        var isNeedUpdateData: Bool = true
        if let weatherData = getLastSessionWeatherData(type: ModelForForecastWeatherRemote.self, forKey: Constans.lastSessionForecastWeatherDataKey) {
            let adaptedData = ModelForForecastWeather(location: weatherData.location, current: weatherData.current, forecast: weatherData.forecast)
            isNeedUpdateData = false
            completion(.success(adaptedData))
        }
        
        weatherAPIService.fetchForecastWeather { result in
            switch result {
            case .success(let weatherData):
                
                self.saveLastSessionWeatherData(weatherData, forKey: Constans.lastSessionForecastWeatherDataKey)
                let adaptedData = ModelForForecastWeather(location: weatherData.location, current: weatherData.current, forecast: weatherData.forecast)
                if isNeedUpdateData {
                    completion(.success(adaptedData))
                }
            case .failure(let error):
                
                completion(.failure(error))
                
            }
        }
    }
    
    private func saveLastSessionWeatherData<T: Codable>(_ weatherData: T, forKey: String) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(weatherData)
            userDefaults.set(encodedData, forKey: forKey)
        } catch {
            logger.error("Error encoding weather data: \(error.localizedDescription)")
        }
    }

    
    private func getLastSessionWeatherData<T:Codable>(type: T.Type, forKey: String) -> T? {
        guard let savedData = userDefaults.data(forKey: forKey) else { return nil }
        do {
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: savedData)
            return decodedData
        } catch {
            logger.error("Error decoding weather data: \(error.localizedDescription)")
            return nil
        }
    }
}
