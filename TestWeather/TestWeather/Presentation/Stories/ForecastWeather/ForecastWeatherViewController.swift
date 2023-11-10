//
//  ScrollView.swift
//  TestWeather
//
//  Created by artem on 30.10.2023.
//

import Foundation
import UIKit

class ForecastWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let scrollView = UIScrollView()
    private let hourlyForecastView = HourlyForecastView()
    private let stackView = UIStackView()
    private let tableView = UITableView()
    private let views = UIView()
    private let precipitationView = PrecipitationView()
    private let averageIndicatorsView = SmallView(titleImageName: Strings.arrowUpRight,
                                                  title: Strings.averageIndicators,
                                                  numeric: Strings.plusEight,
                                                  descriptionText: Strings.peakDailyAverageValue)
    private let indexUfView = SmallView(titleImageName: Strings.sunMaxFill,
                                        title: Strings.indexUf,
                                        numeric: Strings.one,
                                        descriptionText: Strings.low)
    private let bigView = BigView(headerImageName: "wind", headerLabel: "вітер", numericalValuesLabelForWind: "10", numericalValuesLabelGustsOfWind: "15")
    
    private let sunriseView = SmallView(titleImageName: "sunrise.fill", title: "схід сонця", numeric: "07:09", descriptionText: "Захід сонця: 16:41")
    private let feelsLike = SmallView(titleImageName: "thermometer.low", title: "відчуття як", numeric: "10°", descriptionText: "Вітер")
    
    private let weatherConditionView = SmallView(titleImageName: "drop.fill", title: "опади", numeric: "0 мм", descriptionText: "Потім очікується 5 мм")
    private let visibilityView = SmallView(titleImageName: "eye.fill", title: "видимість", numeric: "34 км", descriptionText: "Обсолютно ясно")
    
    private let fourthQuarterView = BigView(headerImageName: "wind", headerLabel: "вітер", numericalValuesLabelForWind: "10", numericalValuesLabelGustsOfWind: "15")
    
    private let humidityView = SmallView(titleImageName: "humidity.fill", title: "вологість", numeric: "76%", descriptionText: "Точка роси зараз 7°.")
    private let pressureView = SmallView(titleImageName: "tirepressure", title: "тиск", numeric: "", descriptionText: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        configureUI()
    }
}

// MARK: - UI
extension ForecastWeatherViewController {
    private func configureUI() {
        setupScrollView()
        setupStackView()
        setupHourlyForecastView()
        setupViews()
        setupTableView()
        setupPrecipitationView()
        setupHorizontalIndicatorsStack()
        setupBigView()
        setupMeteoInfoStackView()
        setupPrecipitationVisibilityStackView()
        setupFourthQuarterView()
        setupHumidityPressureStackView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupHourlyForecastView() {
        hourlyForecastView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(hourlyForecastView)
        
        NSLayoutConstraint.activate([
            hourlyForecastView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupViews() {
        views.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(views)
        
        NSLayoutConstraint.activate([
            views.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor),
            views.heightAnchor.constraint(equalToConstant: 450),
        ])
    }
    
    private func setupPrecipitationView() {
        precipitationView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(precipitationView)
        
        NSLayoutConstraint.activate([
            precipitationView.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor),
            precipitationView.heightAnchor.constraint(equalToConstant: 360)
        ])
    }
    
    private func setupHorizontalIndicatorsStack() {
        let horizontalIndicatorsStack = UIStackView(arrangedSubviews: [averageIndicatorsView, indexUfView])
        horizontalIndicatorsStack.axis = .horizontal
        horizontalIndicatorsStack.spacing = 25
        horizontalIndicatorsStack.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(horizontalIndicatorsStack)
        
        NSLayoutConstraint.activate([
            horizontalIndicatorsStack.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor),
            averageIndicatorsView.widthAnchor.constraint(equalTo: indexUfView.widthAnchor)
        ])
    }
    
    private func setupBigView() {
        stackView.addArrangedSubview(bigView)
        bigView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bigView.widthAnchor.constraint(equalTo:  hourlyForecastView.widthAnchor)
        ])
    }
    
    private func setupMeteoInfoStackView() {
        let meteoInfoStackView = UIStackView(arrangedSubviews: [sunriseView, feelsLike])
        meteoInfoStackView.axis = .horizontal
        meteoInfoStackView.spacing = 25
        meteoInfoStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(meteoInfoStackView)
        
        NSLayoutConstraint.activate([
            meteoInfoStackView.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor),
            sunriseView.widthAnchor.constraint(equalTo: feelsLike.widthAnchor)
        ])
    }
    
    private func setupPrecipitationVisibilityStackView() {
        let precipitationVisibilityStackView = UIStackView(arrangedSubviews: [weatherConditionView, visibilityView])
        precipitationVisibilityStackView.axis = .horizontal
        precipitationVisibilityStackView.spacing = 25
        precipitationVisibilityStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(precipitationVisibilityStackView)
        
        NSLayoutConstraint.activate([
            precipitationVisibilityStackView.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor),
            weatherConditionView.widthAnchor.constraint(equalTo: visibilityView.widthAnchor)
        ])
    }
    
    private func setupFourthQuarterView() {
        stackView.addArrangedSubview(fourthQuarterView)
        fourthQuarterView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fourthQuarterView.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor)
        ])
    }
    
    private func setupHumidityPressureStackView() {
        let humidityPressureStackView = UIStackView(arrangedSubviews: [humidityView, pressureView])
        humidityPressureStackView.axis = .horizontal
        humidityPressureStackView.spacing = 25
        humidityPressureStackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(humidityPressureStackView)
        
        NSLayoutConstraint.activate([
            humidityPressureStackView.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor),
            humidityView.widthAnchor.constraint(equalTo: pressureView.widthAnchor)
        ])
    }
}

// MARK: - setting tableView
extension ForecastWeatherViewController {
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
            tableView.leftAnchor.constraint(equalTo: views.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: views.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: views.bottomAnchor)
            
        ])
        tableView.backgroundColor = UIColor.lightBlue
        tableView.register(ForecastWeatherCustomCell.self, forCellReuseIdentifier: ForecastWeatherCustomCell.forecastCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastWeatherCell = tableView.dequeueReusableCell(withIdentifier: ForecastWeatherCustomCell.forecastCellIdentifier, for: indexPath) as! ForecastWeatherCustomCell
        forecastWeatherCell.backgroundColor = .lightBlue
        return forecastWeatherCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerImage = UIImageView()
        let headerLabel = UILabel()
        
        headerImage.image = UIImage(systemName: Strings.calendar)
        headerImage.tintColor = .gray
        headerView.addSubview(headerImage)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: -10),
            headerImage.leftAnchor.constraint(equalTo: headerView.leftAnchor, constant: 15),
            headerImage.heightAnchor.constraint(equalToConstant: 18),
            headerImage.widthAnchor.constraint(equalToConstant: 18)
        ])
        
        headerLabel.text = Strings.tenDayForecast
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
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
