//
//  MainViewController.swift
//  TestWeather
//
//  Created by artem on 12.10.2023.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    
    let todayWeather = UIButton()
    let forecastWeather = UIButton()
    let currentWeatherButton = CustomButton(title: Strings.currentWeather)
    let forecastWeatherButton = CustomButton(title: Strings.forecastWeather)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
}

// MARK: - UI

private extension MainViewController {
    func configureUI() {
        setupBackground()
        setupCurrentWeatherButton()
        setupForecastWeatherButton()
    }
    
    func setupBackground() {
        let gradientView = GradientBackgroundView(frame: view.bounds)
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(gradientView)
    }
    
    func setupCurrentWeatherButton() {
        view.addSubview(currentWeatherButton)
        currentWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentWeatherButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentWeatherButton.widthAnchor.constraint(equalToConstant: 250),
            currentWeatherButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        currentWeatherButton.addTarget(self, action: #selector(goToCurrentWeatherViewController), for: .touchUpInside)
    }
    
    func setupForecastWeatherButton() {
        view.addSubview(forecastWeatherButton)
        forecastWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastWeatherButton.topAnchor.constraint(equalTo: currentWeatherButton.bottomAnchor, constant: 30),
            forecastWeatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forecastWeatherButton.widthAnchor.constraint(equalToConstant: 250),
            forecastWeatherButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        forecastWeatherButton.addTarget(self, action: #selector(goToForecastWeatherViewController), for: .touchUpInside)
    }
}

// MARK: - action

extension MainViewController {
    @objc func goToCurrentWeatherViewController() {
        let currentWeatherViewController = CurrentWeatherViewController()
        self.show(currentWeatherViewController, sender: self)
    }
    
    @objc func goToForecastWeatherViewController() {
        let forecastWeatherViewController = ForecastWeatherViewController()
        self.show(forecastWeatherViewController, sender: self)
    }
}
