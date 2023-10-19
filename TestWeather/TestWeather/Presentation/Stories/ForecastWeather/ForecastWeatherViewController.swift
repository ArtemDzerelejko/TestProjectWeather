//
//  ForecastWeatherViewController.swift
//  TestWeather
//
//  Created by artem on 16.10.2023.
//

import Foundation
import UIKit

final class ForecastWeatherViewController: UIViewController {
    
    private let forecastWeatherViewModel = ForecastWeatherViewModel()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainDataLabel = UILabel()
    private let backButton = CustomBackButton()
    private let forecastWeatherLabel = CustomLabel(fontSize: 24)
    private let countryLabel = CustomLabel(fontSize: 20)
    private let cityLabel = CustomLabel(fontSize: 20)
    private let loader = CustomLoaderView()
    private let tableView = UITableView()
    private var forecastWeatherData: ModelForForecastWeather?
    private let refreshControl = UIRefreshControl()
    
    private enum Constans {
        static let cell: String = "Cell"
        static let customCell: String = "CustomCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
        configureUI()
        loader.startAnimating()
        onWeatherUpdate(viewModel: forecastWeatherViewModel)
        errorHandler(viewModel: forecastWeatherViewModel)
        forecastWeatherViewModel.getForecastWeather()
    }
    
    private func updateUI(with forecastWeatherData: ModelForForecastWeather) {
        self.forecastWeatherData = forecastWeatherData // Update forecastWeatherData
        
        if let country = forecastWeatherData.location?.country {
            countryLabel.text = Strings.country + ": \(country)"
        }
        
        if let city = forecastWeatherData.location?.name  {
            cityLabel.text = Strings.city + ": \(city)"
        }
        
        tableView.reloadData()
    }
}

//MARK: - forecasr weather Update

private extension ForecastWeatherViewController {
    func onWeatherUpdate(viewModel: ForecastWeatherViewModel) {
        viewModel.onWeatherUpdate = { [weak self] weatherData in
            self?.loader.stopAnimating()
            self?.backButton.isHidden = false
            self?.forecastWeatherLabel.isHidden = false
            self?.updateUI(with: weatherData)
        }
    }
}

// MARK: - error handler

private extension ForecastWeatherViewController {
    func errorHandler(viewModel: ForecastWeatherViewModel) {
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

private extension ForecastWeatherViewController {
    func configureUI() {
        setupBackground()
        setupLoader()
        setupBackButton()
        setupForecastWeatherLabel()
        setupCountryLabel()
        setupCityLabel()
        setupTableView()
        setupRefreshControl()
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
    
    func setupForecastWeatherLabel() {
        forecastWeatherLabel.isHidden = true
        forecastWeatherLabel.text = Strings.forecastWeather
        view.addSubview(forecastWeatherLabel)
        forecastWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            forecastWeatherLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            forecastWeatherLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupCountryLabel() {
        view.addSubview(countryLabel)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countryLabel.topAnchor.constraint(equalTo: forecastWeatherLabel.bottomAnchor, constant: 30),
            countryLabel.centerXAnchor.constraint(equalTo: forecastWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupCityLabel() {
        view.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 10),
            cityLabel.centerXAnchor.constraint(equalTo: forecastWeatherLabel.centerXAnchor)
        ])
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constans.cell)
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupRefreshControl() {
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl.bounds = CGRect(x: 0, y: 0, width: refreshControl.bounds.width, height: 60)
        refreshControl.tintColor = .yellow
        
        let attributedText = NSAttributedString(string: Strings.fetchingWeatherData, attributes: [
            .font: UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ])
        refreshControl.attributedTitle = attributedText
    }
    
}

extension ForecastWeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastWeatherData?.forecast?.forecastday?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ForecastTableViewCell(style: .default, reuseIdentifier: Constans.customCell)
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        
        if let forecast = forecastWeatherData?.forecast?.forecastday?[indexPath.row] {
            if let date = forecast.date,
               let maxTemp = forecast.day?.maxtempCelsius,
               let minTemp = forecast.day?.mintempCelsius,
               let chanceOfRain = forecast.day?.dailyChanceOfRain
            {
                cell.dateLabel.text = date
                cell.maxTempLabel.text = Strings.maxTemperature + ": \(maxTemp)"
                cell.minTempLabel.text = Strings.minTemperature + ": \(minTemp)"
                cell.chanceOfRainLabel.text = Strings.chanceOfRain + ": \(chanceOfRain)"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}


// MARK: - action

extension ForecastWeatherViewController {
    @objc func moveToMainViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func refreshData() {
        forecastWeatherViewModel.getForecastWeather()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.refreshControl.endRefreshing()
        }
    }
}
