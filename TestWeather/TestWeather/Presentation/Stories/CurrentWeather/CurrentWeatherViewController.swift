//
//  CurrentWeather.swift
//  TestWeather
//
//  Created by artem on 16.10.2023.
//

import Foundation
import UIKit

final class CurrentWeatherViewController: UIViewController {
    
    private let viewModel = CurrentWeatherViewModel()
    private let backButton = CustomBackButton()
    private let refrechButton = RefrechButton()
    private let currentWeatherLabel = CustomLabel()
    private let countryLabel = CustomLabel()
    private let cityLabel = CustomLabel()
    private let dateAndTimeLabel = CustomLabel()
    private let cloudLabel = CustomLabel()
    private let cloudImageView = CustomImageView()
    private let tempCelsiusLabel = CustomLabel()
    private let tempFahrenheitLabel = CustomLabel()
    private let feelslikeCelsiusLabel = CustomLabel()
    private let feelslikeFahrenheitLabel = CustomLabel()
    private let weatherTipsLabel = CustomLabel()
    private let loader = CustomLoaderView()
    private let temperatureSegmentedControl = UISegmentedControl(items: ["°C", "°F"])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        configureUI()
        loader.startAnimating()
        onWeatherUpdate(viewModel: viewModel)
        errorHandler(viewModel: viewModel)
        viewModel.getWeather()
    }
}

// MARK: - updateUI

private extension CurrentWeatherViewController {
    func updateUI(with weatherData: ModelForCurrentWeather) {
        // MARK: - setting country
        if let country = weatherData.location?.country {
            countryLabel.text = Strings.country + ": \(country)"
        }
        
        // MARK: - setting city
        if let city = weatherData.location?.name {
            cityLabel.text = Strings.city + ": \(city)"
        }
        
        // MARK: - setting localtime
        if let localtime = weatherData.location?.localtime {
            dateAndTimeLabel.text = Strings.dateAndTime + ": \(localtime)"
        }
        
        // MARK: - setting cloud
        if let cloud = weatherData.current?.cloud {
            cloudLabel.text = Strings.cloud + ": \(cloud)"
            self.checkClound(for: cloud)
        }
        
        // MARK: - setting temp Celsius
        if let tempCelsius = weatherData.current?.tempCelsius {
            tempCelsiusLabel.text = Strings.tempCelsius + ": \(tempCelsius)"
        }
        
        // MARK: - setting temp Fahrenheit
        if let tempFahrenheit = weatherData.current?.tempFahrenheit {
            tempFahrenheitLabel.text = Strings.tempFahrenheit + ": \(tempFahrenheit)"
        }
        
        // MARK: - setting feelslike Celsius
        if let feelslikeCelsius = weatherData.current?.feelslikeCelsius {
            feelslikeCelsiusLabel.text = Strings.feelsLike + ": \(feelslikeCelsius)"
            setWeatherTips(for: feelslikeCelsius)
        }
        
        // MARK: - setting feelslike Fahrenheit
        if let feelslikeFahrenheit = weatherData.current?.feelslikeFahrenheit {
            feelslikeFahrenheitLabel.text = Strings.feelsLike + ": \(feelslikeFahrenheit)"
        }
    }
}

// MARK: - verification and installation of pictures

private extension CurrentWeatherViewController {
    func checkClound(for cloud: Int) {
        switch cloud {
        case 0...30:
            cloudImageView.image = UIImage(systemName: Strings.sunMaxFill)
        case 31...70:
            cloudImageView.image = UIImage(systemName: Strings.cloudFill)
        case 71...100:
            cloudImageView.image = UIImage(systemName: Strings.smokeFill)
        default:
            cloudImageView.image = nil
        }
    }
    
    func setWeatherTips(for temperature: Double) {
        switch temperature {
        case -30..<(-10):
            weatherTipsLabel.text = Strings.recommendationToMinusThirty
        case -10..<0:
            weatherTipsLabel.text = Strings.recommendationToMinusNine
        case 0..<11:
            weatherTipsLabel.text = Strings.recommendationToPlusOne
        case 11..<21:
            weatherTipsLabel.text = Strings.recommendationToPlusEleven
        case 21..<31:
            weatherTipsLabel.text = Strings.recommendationToPlusTwentyOne
        case 31..<41:
            weatherTipsLabel.text = Strings.recommendationToPlusThirtyOne
        default:
            weatherTipsLabel.text = Strings.standardWeatherTips
        }
    }
}

// MARK: - current weather Update

private extension CurrentWeatherViewController {
    func onWeatherUpdate(viewModel: CurrentWeatherViewModel) {
        viewModel.onWeatherUpdate = { [weak self] weatherData in
            self?.loader.stopAnimating()
            self?.backButton.isHidden = false
            self?.currentWeatherLabel.isHidden = false
            self?.refrechButton.isHidden = false
            self?.temperatureSegmentedControl.isHidden = false
            self?.updateUI(with: weatherData)
        }
    }
}

// MARK: - error handler

private extension CurrentWeatherViewController {
    func errorHandler(viewModel: CurrentWeatherViewModel) {
        viewModel.onError = { [weak self] error in
            self?.showErrorAlert(error)
        }
    }
    
    func showErrorAlert(_ error: Error) {
        let alert = UIAlertController(title: Strings.error, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UI

private extension CurrentWeatherViewController {
    func configureUI() {
        setupBackground()
        setupLoader()
        setupBackButton()
        setupCurrentWeather()
        setupRefrechButton()
        setupCountryLabel()
        setupCityLabel()
        setupLocalTimeLabel()
        setupCloudLabel()
        setupCloudImageView()
        setupTemperatureSegmentedControl()
        setupTempCelsius()
        setupFeelslikeLabelCelsius()
        setupWeatherTipsLabel()
    }
    
    func setupBackground() {
        let gradientView = GradientBackgroundView(frame: view.bounds)
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(gradientView)
    }
    
    func setupLoader() {
        view.addSubview(loader)
        loader.center = view.center
    }
    
    func setupBackButton() {
        view.addSubview(backButton)
        backButton.isHidden = true
        backButton.tintColor = .white
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 50),
            backButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        backButton.addTarget(self, action: #selector(moveToMainViewController), for: .touchUpInside)
    }
    
    func setupCurrentWeather() {
        currentWeatherLabel.isHidden = true
        currentWeatherLabel.text = Strings.currentWeather
        view.addSubview(currentWeatherLabel)
        currentWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentWeatherLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            currentWeatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    func setupRefrechButton() {
        view.addSubview(refrechButton)
        refrechButton.isHidden = true
        refrechButton.tintColor = .white
        refrechButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            refrechButton.topAnchor.constraint(equalTo: backButton.topAnchor),
            refrechButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            refrechButton.widthAnchor.constraint(equalToConstant: 55),
            refrechButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        refrechButton.addTarget(self, action: #selector(refrechData), for: .touchUpInside)
    }
    
    func setupCountryLabel() {
        view.addSubview(countryLabel)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: currentWeatherLabel.bottomAnchor, constant: 100),
            countryLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
        
    }
    
    func setupCityLabel() {
        view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            cityLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupLocalTimeLabel() {
        view.addSubview(dateAndTimeLabel)
        dateAndTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateAndTimeLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            dateAndTimeLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupCloudLabel() {
        view.addSubview(cloudLabel)
        cloudLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cloudLabel.topAnchor.constraint(equalTo: dateAndTimeLabel.bottomAnchor, constant: 20),
            cloudLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupCloudImageView() {
        view.addSubview(cloudImageView)
        cloudImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cloudImageView.topAnchor.constraint(equalTo: cloudLabel.bottomAnchor, constant: 15),
            cloudImageView.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor),
            cloudImageView.widthAnchor.constraint(equalToConstant: 100),
            cloudImageView.heightAnchor.constraint(equalToConstant: 75)
        ])
    }
    
    func setupTemperatureSegmentedControl() {
        view.addSubview(temperatureSegmentedControl)
        temperatureSegmentedControl.isHidden = true
        temperatureSegmentedControl.selectedSegmentIndex = 0
        temperatureSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperatureSegmentedControl.topAnchor.constraint(equalTo: cloudImageView.bottomAnchor, constant: 20),
            temperatureSegmentedControl.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor),
            temperatureSegmentedControl.widthAnchor.constraint(equalToConstant: 150),
            temperatureSegmentedControl.heightAnchor.constraint(equalToConstant: 50)
        ])
        temperatureSegmentedControl.addTarget(self, action: #selector(temperatureUnitChanged), for: .valueChanged)
    }
    
    func setupTempCelsius() {
        view.addSubview(tempCelsiusLabel)
        tempCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempCelsiusLabel.topAnchor.constraint(equalTo: temperatureSegmentedControl.bottomAnchor, constant: 10),
            tempCelsiusLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
        
    }
    
    func setupTempFahrenheit() {
        view.addSubview(tempFahrenheitLabel)
        tempFahrenheitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tempFahrenheitLabel.topAnchor.constraint(equalTo: temperatureSegmentedControl.bottomAnchor, constant: 10),
            tempFahrenheitLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupFeelslikeLabelCelsius() {
        view.addSubview(feelslikeCelsiusLabel)
        feelslikeCelsiusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feelslikeCelsiusLabel.topAnchor.constraint(equalTo: tempCelsiusLabel.bottomAnchor, constant: 20),
            feelslikeCelsiusLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupFeelslikeLabelFahrenheit() {
        view.addSubview(feelslikeFahrenheitLabel)
        feelslikeFahrenheitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feelslikeFahrenheitLabel.topAnchor.constraint(equalTo: tempCelsiusLabel.bottomAnchor, constant: 20),
            feelslikeFahrenheitLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupWeatherTipsLabel() {
        weatherTipsLabel.numberOfLines = 0
        weatherTipsLabel.textAlignment = .center
        view.addSubview(weatherTipsLabel)
        weatherTipsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherTipsLabel.topAnchor.constraint(equalTo: feelslikeCelsiusLabel.bottomAnchor, constant: 15),
            weatherTipsLabel.centerXAnchor.constraint(equalTo: currentWeatherLabel.centerXAnchor),
            weatherTipsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weatherTipsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}

// MARK: - action

extension CurrentWeatherViewController {
    @objc func moveToMainViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func refrechData() {
        viewModel.getWeather()
    }
    
    @objc func temperatureUnitChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            tempCelsiusLabel.isHidden = false
            feelslikeCelsiusLabel.isHidden = false
            tempFahrenheitLabel.isHidden = true
            feelslikeFahrenheitLabel.isHidden = true
            
        case 1:
            setupTempFahrenheit()
            setupFeelslikeLabelFahrenheit()
            tempCelsiusLabel.isHidden = true
            feelslikeCelsiusLabel.isHidden = true
            tempFahrenheitLabel.isHidden = false
            feelslikeFahrenheitLabel.isHidden = false
            
        default:
            break
        }
    }
    
}
