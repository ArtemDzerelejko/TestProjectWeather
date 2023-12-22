//
//  ForecastWeatherCell.swift
//  TestWeather
//
//  Created by artem on 27.10.2023.
//

import Foundation
import UIKit

final class ForecastWeatherCustomCell: UITableViewCell {
    
    private lazy var weekdayLabel = UILabel().with {
        $0.text = Strings.weekday
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var weatherImage = UIImageView().with {
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var temperatureLabel = UILabel().with {
        $0.text = "15°"
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static let forecastCellIdentifier = Keys.forecastWeatherCell
    static let forecastWeatherViewModel = ForecastWeatherViewModel(country: Strings.ukraine)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension ForecastWeatherCustomCell {
    func configureUI() {
        setupWeekdayLabel()
        setupWeatherImage()
        setupTemperatureLabel()
    }
    
    func setupWeekdayLabel() {
        addSubview(weekdayLabel)

        NSLayoutConstraint.activate([
            weekdayLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            weekdayLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            weekdayLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
    }
    
    func setupWeatherImage() {
        if let randomImageName = ForecastWeatherCustomCell.forecastWeatherViewModel.systemImagesForForecastWeatherCustomCell.randomElement() {
            weatherImage.image = UIImage(systemName: randomImageName)
        }
        addSubview(weatherImage)

        NSLayoutConstraint.activate([
            weatherImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            weatherImage.heightAnchor.constraint(equalToConstant: 30),
            weatherImage.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setupTemperatureLabel() {
        addSubview(temperatureLabel)
      
        NSLayoutConstraint.activate([
            temperatureLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
}
