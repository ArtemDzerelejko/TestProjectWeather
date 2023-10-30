//
//  ScrollView.swift
//  TestWeather
//
//  Created by artem on 30.10.2023.
//

import Foundation
import UIKit

class ForecastWeathersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let hourlyForecastView = HourlyForecastView()
    private let tableView = UITableView()
    private let views = UIView()
    private let precipitationView = PrecipitationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        configureUI()
    }
}

// MARK: - UI
extension ForecastWeathersViewController {
    private func configureUI() {
        setupScrollView()
        setupContentView()
    }

    private func setupScrollView() {
        scrollView.backgroundColor = .systemRed
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContentView() {
        contentView.backgroundColor = .systemPurple
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 2)
        ])
        
        setupHourlyForecastView()
        setupViews()
        setupTableView()
        setupPrecipitationView()
    }
    
    private func setupHourlyForecastView() {
        hourlyForecastView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(hourlyForecastView)
        
        NSLayoutConstraint.activate([
            hourlyForecastView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            hourlyForecastView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hourlyForecastView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hourlyForecastView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupViews() {
        contentView.addSubview(views)
        views.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            views.topAnchor.constraint(equalTo: hourlyForecastView.bottomAnchor, constant: 20),
            views.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            views.widthAnchor.constraint(equalToConstant: 360),
            views.heightAnchor.constraint(equalToConstant: 450)
        ])
    }

    private func setupPrecipitationView() {
        contentView.addSubview(precipitationView)
        precipitationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            precipitationView.topAnchor.constraint(equalTo: views.bottomAnchor, constant: 20),
            precipitationView.centerXAnchor.constraint(equalTo: views.centerXAnchor),
        ])
    }
}

   

// MARK: - setting tableView
extension ForecastWeathersViewController {
    private func setupTableView() {
        views.addSubview(tableView)
        tableView.layer.cornerRadius = 15
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.separatorColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: views.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: views.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: views.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: views.bottomAnchor)

        ])
        tableView.backgroundColor = UIColor.lightBlue
        tableView.register(ForecastWeatherCell.self, forCellReuseIdentifier: "forecastWeatherCell")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastWeatherCell = tableView.dequeueReusableCell(withIdentifier: "forecastWeatherCell", for: indexPath) as! ForecastWeatherCell
        forecastWeatherCell.backgroundColor = .lightBlue
        return forecastWeatherCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Ви натиснули на ячейку з номером \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerImage = UIImageView()
        let headerLabel = UILabel()

        headerImage.image = UIImage(systemName: "calendar")
        headerImage.tintColor = .gray
        headerView.addSubview(headerImage)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: -10),
            headerImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            headerImage.heightAnchor.constraint(equalToConstant: 18),
            headerImage.widthAnchor.constraint(equalToConstant: 18)
        ])

        headerLabel.text = "10-денний прогноз"
        headerLabel.font = UIFont.systemFont(ofSize: 15)
        headerLabel.textColor = .gray
        headerView.addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerImage.topAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: headerImage.trailingAnchor, constant: 5)
        ])


        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
