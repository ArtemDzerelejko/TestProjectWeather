//
//  LocationWeatherCell.swift
//  TestWeather
//
//  Created by artem on 18.12.2023.
//

import UIKit
import AVFoundation

final class LocationWeatherCell: UITableViewCell {
    
    private lazy var mainView = UIView().with {
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .lightBlue
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var cityTimeStackView = СityTimeStackView(city: ForecastWeatherViewModel.locationCity, time: ForecastWeatherViewModel.time).with {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var weatherInfoStackView = WeatherInfoStackView(weather: ForecastWeatherViewModel.weather, higher: ForecastWeatherViewModel.higher, lower: ForecastWeatherViewModel.lower).with {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var temperatureLabel = UILabel().with {
        $0.text = ForecastWeatherViewModel.temperature
        $0.font = UIFont.systemFont(ofSize: 50, weight: .medium)
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setupUI
private extension LocationWeatherCell {
    func configureUI() {
        backgroundColor = .clear
        setupMainView()
        setupVerticalStackView()
        setupTemperatureLabel()
        setupHorizontalStackView()
    }
    
    func setupMainView() {
        addSubview(mainView)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }
    
    func setupVerticalStackView() {
        mainView.addSubview(cityTimeStackView)
        
        NSLayoutConstraint.activate([
            cityTimeStackView.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 5),
            cityTimeStackView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10)
        ])
    }
    
    func setupTemperatureLabel() {
        mainView.addSubview(temperatureLabel)
        
        NSLayoutConstraint.activate([
            temperatureLabel.topAnchor.constraint(equalTo: cityTimeStackView.topAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -15)
        ])
    }
    
    func setupHorizontalStackView() {
        mainView.addSubview(weatherInfoStackView)
        
        NSLayoutConstraint.activate([
            weatherInfoStackView.topAnchor.constraint(equalTo: cityTimeStackView.bottomAnchor, constant: 10),
            weatherInfoStackView.leadingAnchor.constraint(equalTo: cityTimeStackView.leadingAnchor),
            weatherInfoStackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10)
        ])
    }
}
