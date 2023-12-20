//
//  WeatherInfoStackView.swift
//  TestWeather
//
//  Created by artem on 19.12.2023.
//

import UIKit

class WeatherInfoStackView: UIStackView {
    
    private lazy var weatherInfo = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var temperatureRange = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(weather: String, higher: String, lower: String) {
        super.init(frame: .zero)
        configureUI(weather: weather, higher: higher, lower: lower)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setupUI
private extension WeatherInfoStackView {
    func configureUI(weather: String, higher: String, lower: String) {
        setupWeatherInfo(weather: weather)
        setupTemperatureRange(higher: higher, lower: lower)
    }
    
    func setupWeatherInfo(weather: String) {
        weatherInfo.text = weather
        addArrangedSubview(weatherInfo)
    }
    
    func setupTemperatureRange(higher: String, lower: String) {
        temperatureRange.text = "В:\(higher) H:\(lower)"
        addArrangedSubview(temperatureRange)
    }
}
