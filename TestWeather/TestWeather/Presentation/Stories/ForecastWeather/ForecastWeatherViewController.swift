//
//  ScrollView.swift
//  TestWeather
//
//  Created by artem on 30.10.2023.
//

import Foundation
import UIKit
import AVFoundation
import AVKit


final class ForecastWeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: ForecastWeatherViewModel!
    
    private lazy var scrollView = UIScrollView().with {
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let hourlyForecastView = HourlyForecastView()
    
    private lazy var stackView = UIStackView().with {
        $0.axis = .vertical
        $0.spacing = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var tableView = UITableView().with {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.layer.cornerRadius = 15
        $0.delegate = self
        $0.dataSource = self
        $0.isScrollEnabled = false
        $0.separatorColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var views = UIView().with {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let precipitationView = PrecipitationView()
    private var headerView: HeaderView!
    
    private let averageIndicatorsView = WeatherDetailInfoView(titleImageName: Strings.arrowUpRight,
                                                              title: Strings.averageIndicators,
                                                              numeric: Strings.plusEight,
                                                              descriptionText: Strings.peakDailyAverageValue)
    
    private let indexUfView = WeatherDetailInfoView(titleImageName: Strings.sunMaxFill,
                                                    title: Strings.indexUf,
                                                    numeric: Strings.one,
                                                    descriptionText: Strings.low)
    
    private let weatherInfoView = WeatherInfoView()
    
    private let sunriseView = WeatherDetailInfoView(titleImageName: Strings.sunriseFill,
                                                    title: Strings.sunrise,
                                                    numeric: "07:09",
                                                    descriptionText: Strings.sunset + ": 16:41")
    
    private let feelsLike = WeatherDetailInfoView(titleImageName: Strings.thermometerLow,
                                                  title: Strings.feelingLike,
                                                  numeric: "10°",
                                                  descriptionText: Strings.wind)
    
    private let weatherConditionView = WeatherDetailInfoView(titleImageName: Strings.dropFill,
                                                             title: Strings.precipitation,
                                                             numeric: "0 мм",
                                                             descriptionText: Strings.thenItIsExpected + " 5 мм")
    
    private let visibilityView = WeatherDetailInfoView(titleImageName: Strings.eyeFill,
                                                       title: Strings.visibility,
                                                       numeric: "34 км",
                                                       descriptionText: Strings.absolutelyClear)
    
    private let quarterView = QuarterView()
    
    private let humidityView = WeatherDetailInfoView(titleImageName: Strings.humidityFill,
                                                     title: Strings.humidity,
                                                     numeric: "76%",
                                                     descriptionText: Strings.dewPointNow + " 7°.")
    
    private let pressureView = WeatherDetailInfoView(titleImageName: Strings.tirepressure,
                                                     title: Strings.pressure,
                                                     numeric: "",
                                                     descriptionText: "")
    
    private let compassView = WeatherDetailInfoView(titleImageName: Strings.locationNorth,
                                                    title: Strings.compass,
                                                    numeric: "",
                                                    descriptionText: "")
    
    private let compassArrowView = CompassView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = HeaderView(city: viewModel.country, temperature: ForecastWeatherViewModel.temperature, weather: ForecastWeatherViewModel.weather)
        configureUI()
    }
}

// MARK: - UI

extension ForecastWeatherViewController {
    private func configureUI() {
        setupScrollView()
        setupStackView()
        setupHeaderView()
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
        setupCompassView()
        setupCompassImageView()
    }
    
    public func setupBackgroundVideo(player: AVPlayer) {
        //       AVPlayerItem
        //        player.currentItem
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        view.layer.insertSublayer(playerLayer, at: 0)
        player.play()
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem,
                                               queue: nil) { [weak player] _ in
            player?.seek(to: CMTime.zero)
            player?.play()
        }
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupStackView() {
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    private func setupHeaderView() {
        stackView.addArrangedSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -40),
        ])
    }
    
    private func setupHourlyForecastView() {
        stackView.addArrangedSubview(hourlyForecastView)
        
        NSLayoutConstraint.activate([
            hourlyForecastView.widthAnchor.constraint(equalTo: headerView.widthAnchor),
            hourlyForecastView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    private func setupViews() {
        stackView.addArrangedSubview(views)
        
        NSLayoutConstraint.activate([
            views.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor),
            views.heightAnchor.constraint(equalToConstant: 450),
        ])
    }
    
    private func setupPrecipitationView() {
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
        stackView.addArrangedSubview(weatherInfoView)
        
        NSLayoutConstraint.activate([
            weatherInfoView.widthAnchor.constraint(equalTo:  hourlyForecastView.widthAnchor)
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
        stackView.addArrangedSubview(quarterView)
        
        NSLayoutConstraint.activate([
            quarterView.widthAnchor.constraint(equalTo: hourlyForecastView.widthAnchor)
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
    
    private func setupCompassView() {
        stackView.addArrangedSubview(compassView)
        compassView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            compassView.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    private func setupCompassImageView() {
        compassView.addSubview(compassArrowView)
        
        NSLayoutConstraint.activate([
            compassArrowView.centerXAnchor.constraint(equalTo: compassView.centerXAnchor),
            compassArrowView.centerYAnchor.constraint(equalTo: compassView.centerYAnchor)
        ])
    }
}

// MARK: - setting tableView
extension ForecastWeatherViewController {
    private func setupTableView() {
        views.addSubview(tableView)
    
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: views.topAnchor),
            tableView.leftAnchor.constraint(equalTo: views.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: views.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: views.bottomAnchor)
            
        ])
        let blurView = BlurredBackgroundViewHelper.createBlurView(with: .light, for: tableView)
        tableView.backgroundView = blurView
        tableView.register(ForecastWeatherCustomCell.self, forCellReuseIdentifier: ForecastWeatherCustomCell.forecastCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastWeatherCell = tableView.dequeueReusableCell(withIdentifier: ForecastWeatherCustomCell.forecastCellIdentifier, for: indexPath) as! ForecastWeatherCustomCell
        let blurView = BlurredBackgroundViewHelper.createBlurView(with: .light, for: tableView)
        forecastWeatherCell.backgroundView = blurView
        forecastWeatherCell.backgroundColor = .clear
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
        headerImage.tintColor = .white
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
        headerLabel.textColor = .white
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
