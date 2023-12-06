//
//  MainViewController.swift
//  TestWeather
//
//  Created by artem on 12.10.2023.
//

import AVFoundation
import UIKit

final class MainViewController: UIViewController {
    
    let todayWeather = UIButton()
    let forecastWeather = UIButton()
    let currentWeatherButton = CustomButton(title: Strings.currentWeather)
    let forecastWeatherButton = CustomButton(title: Strings.forecastWeather)
    var player: AVPlayer!
    
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
        setupVideoPath()
    }
    
    func setupVideoPath() {
        if let videoPath = Bundle.main.path(forResource: "space", ofType: "mp4") {
            player = AVPlayer(url: URL(fileURLWithPath: videoPath))
        }
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
        forecastWeatherViewController.loadViewIfNeeded()
        forecastWeatherViewController.setupBackgroundVideo(player: player)
        self.show(forecastWeatherViewController, sender: self)
    }
}
