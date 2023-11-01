//
//  ForecastWeatherCell.swift
//  TestWeather
//
//  Created by artem on 27.10.2023.
//

import Foundation
import UIKit

class ForecastWeatherCell: UITableViewCell {
    
    private let weekdayLabel = UILabel()
    private let weatherImage = UIImageView()
    private let temperatureLabel = UILabel()
    private let systemImages = ["cloud.sun", "sun.max", "moon", "cloud.rain", "cloud.bolt"]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI
extension ForecastWeatherCell {
    private func configureUI() {
        setupWeekdayLabel()
        setupWeatherImage()
        setupTemperatureLabel()
    }
    
    private func setupWeekdayLabel() {
        addSubview(weekdayLabel)
        weekdayLabel.text = Strings.weekday
        weekdayLabel.textColor = .white
        weekdayLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            weekdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            weekdayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    private func setupWeatherImage() {
        if let randomImageName = systemImages.randomElement() {
            weatherImage.image = UIImage(systemName: randomImageName)
        }
        weatherImage.tintColor = .white
        addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 30),
            weatherImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setupTemperatureLabel() {
        temperatureLabel.text = "15°"
        temperatureLabel.textColor = .white
        addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
