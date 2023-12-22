//
//  MainViewController.swift
//  TestWeather
//
//  Created by artem on 12.10.2023.
//

import AVFoundation
import UIKit

final class MainViewController: UIViewController {

    private let forecastWeatherButton = CustomButton(title: Strings.forecastWeather)
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
        setupForecastWeatherButton()
        setupVideoPath()
    }
    
    func setupVideoPath() {
        if let videoPath = Bundle.main.path(forResource: "sun", ofType: "mp4") {
            player = AVPlayer(url: URL(fileURLWithPath: videoPath))
        }
    }
    
    func setupBackground() {
        let gradientView = GradientBackgroundView(frame: view.bounds)
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(gradientView)
    }
    
    func setupForecastWeatherButton() {
        view.addSubview(forecastWeatherButton)

        NSLayoutConstraint.activate([
            forecastWeatherButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            forecastWeatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            forecastWeatherButton.widthAnchor.constraint(equalToConstant: 250),
            forecastWeatherButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        forecastWeatherButton.addTarget(self, action: #selector(goToForecastWeatherViewController), for: .touchUpInside)
    }
}

// MARK: - action

private extension MainViewController {
    @objc func goToForecastWeatherViewController() {
        let forecastWeatherViewController: ForecastWeatherViewController = WeatherFactory.getWeather(forCountry: Strings.ukraine)
        forecastWeatherViewController.loadViewIfNeeded()
        forecastWeatherViewController.setupBackgroundVideo(player: player)
        self.show(forecastWeatherViewController, sender: self)
    }
}
