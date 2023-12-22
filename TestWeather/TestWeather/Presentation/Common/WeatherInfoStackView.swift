//
//  WeatherInfoStackView.swift
//  TestWeather
//
//  Created by artem on 19.12.2023.
//

import UIKit

final class WeatherInfoStackView: UIStackView {
    
    private lazy var weatherInfoLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var temperatureRangeLabel = UILabel().with {
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

// MARK: - UI

private extension WeatherInfoStackView {
    func configureUI(weather: String, higher: String, lower: String) {
        setupWeatherInfoLabel(weather: weather)
        setupTemperatureRangeLabel(higher: higher, lower: lower)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupWeatherInfoLabel(weather: String) {
        weatherInfoLabel.text = weather
        addArrangedSubview(weatherInfoLabel)
    }
    
    func setupTemperatureRangeLabel(higher: String, lower: String) {
        temperatureRangeLabel.text = "В:\(higher) H:\(lower)"
        addArrangedSubview(temperatureRangeLabel)
    }
}
