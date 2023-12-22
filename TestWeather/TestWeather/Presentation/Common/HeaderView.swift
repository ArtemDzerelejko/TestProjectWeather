//
//  HeaderView.swift
//  TestWeather
//
//  Created by artem on 05.12.2023.
//

import UIKit

final class HeaderView: UIView {
    
    private lazy var verticalStackView = UIStackView().with {
        $0.axis = .vertical
        $0.spacing = 3
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var cityNameLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var temperatureLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 80, weight: .thin)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
        
    private lazy var weatherConditionLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var horizantalStackView = UIStackView().with {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.distribution  = .fillEqually
        $0.spacing = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let heightTemperature = TemperatureInfo(temperatureInfo: "В:", temperatureNumber: "4")
    private let lowTemperature = TemperatureInfo(temperatureInfo: "Н:", temperatureNumber: "3")
    
    init(city: String, temperature: String, weather: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configureUI(city: city, temperature: temperature, weather: weather)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension HeaderView {
    func configureUI(city: String, temperature: String, weather: String) {
        setupVerticalStackView(city: city, temperature: temperature, weather: weather)
    }
    
    func setupVerticalStackView(city: String, temperature: String, weather: String) {
        addSubview(verticalStackView)
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupCityNameLabel(city: city)
        setupTemperatureLabel(temperature: temperature)
        setupWeatherConditionLabel(weather: weather)
        setupHorizantalStackView()
    }
    
    func setupCityNameLabel(city: String) {
        verticalStackView.addArrangedSubview(cityNameLabel)
        cityNameLabel.text = city
    }
    
    func setupTemperatureLabel(temperature: String) {
        verticalStackView.addArrangedSubview(temperatureLabel)
        temperatureLabel.text = temperature
    }
    
    func setupWeatherConditionLabel(weather: String) {
        verticalStackView.addArrangedSubview(weatherConditionLabel)
        weatherConditionLabel.text = weather
    }
    
    func setupHorizantalStackView() {
        verticalStackView.addArrangedSubview(horizantalStackView)
        horizantalStackView.addArrangedSubview(heightTemperature)
        horizantalStackView.addArrangedSubview(lowTemperature)
       
        NSLayoutConstraint.activate([
            horizantalStackView.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            horizantalStackView.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
        ])
    }
}
