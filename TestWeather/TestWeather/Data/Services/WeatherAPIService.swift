//
//  APIService.swift
//  TestWeather
//
//  Created by artem on 15.10.2023.
//

import Foundation
import Alamofire

final class WeatherAPIService {
    
    private static let apiKey = "1d99baeca95549f48e1121104231210"
    private static let baseURL = "http://api.weatherapi.com/v1"
    
    private enum Constans {
        static let defaultLocation: String = "Ukraine"
        static let defaultAQI: String = "defaultAQI"
        static let numberOfDays: String = "7"
        static let currentJson: String = "/current.json"
        static let forecastJson: String = "/forecast.json"
        static let invalidURL: String = "Invalid URL"
    }
    
    private static func makeWeatherURL(endpoint: String, parameters: [String: String]) -> URL? {
        var components = URLComponents(string: baseURL + endpoint)
        components?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url
    }
    
    private func fetchData(fromEndpoint endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = WeatherAPIService.makeWeatherURL(endpoint: endpoint, parameters: ["key": WeatherAPIService.apiKey, "q": Constans.defaultLocation, "aqi": Constans.defaultAQI]) else {
            completion(.failure(NSError(domain: Constans.invalidURL, code: -1, userInfo: nil)))
            return
        }
        
        AF.request(url).validate().responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCurrentWeather(completion: @escaping (Result<ModelForCurrentWeatherRemote, Error>) -> Void) {
        fetchData(fromEndpoint: Constans.currentJson) { result in
            switch result {
            case .success(let data):
                do {
                    let weatherData = try JSONDecoder().decode(ModelForCurrentWeatherRemote.self, from: data)
                    completion(.success(weatherData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchForecastWeather(completion: @escaping (Result<ModelForForecastWeatherRemote, Error>) -> Void) {
        guard let url = WeatherAPIService.makeWeatherURL(endpoint: Constans.forecastJson, parameters: ["key": WeatherAPIService.apiKey, "q": Constans.defaultLocation, "aqi": Constans.defaultAQI, "days": Constans.numberOfDays]) else {
            completion(.failure(NSError(domain: Constans.invalidURL, code: -1, userInfo: nil)))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: ModelForForecastWeatherRemote.self) { response in
            switch response.result {
            case .success(let forecastWeatherData):
                completion(.success(forecastWeatherData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
