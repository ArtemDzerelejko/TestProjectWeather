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
    private let stackView = UIStackView()
    private let tableView = UITableView()
    private let views = UIView()
    private let precipitationView = PrecipitationView()
    private let averageIndicatorsView = SmallView(titleImage: Strings.arrowUpRight,
                                                  title: Strings.averageIndicators,
                                                  numeric: Strings.plusEight,
                                                  descriptionText: Strings.peakDailyAverageValue)
    private let indexUfView = SmallView(titleImage: Strings.sunMaxFill,
                                        title: Strings.indexUf,
                                        numeric: Strings.one,
                                        descriptionText: Strings.low)
    
    private let forecastCellIdentifier = "forecastWeatherCell"
    //    let compasView = CompassView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        configureUI()
    }
}

// MARK: - UI
extension ForecastWeathersViewController {
    private func configureUI() {
        setupScrollView()
        setupStackView()
        setupHourlyForecastView()
        setupViews()
        setupTableView()
        setupPrecipitationView()
        setupHorizontalIndicatorsStack()
        //        setupCompassView()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
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
            precipitationView.widthAnchor.constraint(equalTo:  hourlyForecastView.widthAnchor),
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
    
    //    private func setupCompassView() {
    //        stackView.addArrangedSubview(compasView)
    //
    //        compasView.translatesAutoresizingMaskIntoConstraints = false
    //
    //        NSLayoutConstraint.activate([
    ////            compasView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
    ////            compasView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
    ////            compasView.widthAnchor.constraint(equalToConstant: 200), // Встановіть бажану ширину
    //            compasView.heightAnchor.constraint(equalToConstant: 200) // Встановіть бажану висоту
    //        ])
    //    }
    
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
        tableView.register(ForecastWeatherCell.self, forCellReuseIdentifier: forecastCellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastWeatherCell = tableView.dequeueReusableCell(withIdentifier: forecastCellIdentifier, for: indexPath) as! ForecastWeatherCell
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
        
        headerImage.image = UIImage(systemName: Strings.calendar)
        headerImage.tintColor = .gray
        headerView.addSubview(headerImage)
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: -10),
            headerImage.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
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
}

//import UIKit
//
//class CompassView: UIView {
//    override func draw(_ rect: CGRect) {
//        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
//        let squareSize = min(rect.width, rect.height)
//        let radius = squareSize / 2 - 10
//
//        // Ось якщо ви хочете, щоб коло було обрізане до квадрата
//        self.clipsToBounds = true
//
//        // Малюємо коло
//        UIColor.white.setStroke()
//        let dashedPath = UIBezierPath()
//        dashedPath.lineWidth = 1
//        dashedPath.setLineDash([5, 5], count: 2, phase: 0)
//
//        for angle in stride(from: 0, to: CGFloat.pi * 2, by: CGFloat.pi / 48) {
//            let startPoint = CGPoint(x: center.x + cos(angle) * (radius - 5), y: center.y + sin(angle) * (radius - 5))
//            let endPoint = CGPoint(x: center.x + cos(angle) * (radius + 5), y: center.y + sin(angle) * (radius + 5))
//            dashedPath.move(to: startPoint)
//            dashedPath.addLine(to: endPoint)
//        }
//
//        dashedPath.stroke()
//
//        // Малюємо стрілку
//        UIColor.red.setFill()
//        let arrowPath = UIBezierPath()
//        arrowPath.move(to: CGPoint(x: center.x, y: center.y - radius))
//        arrowPath.addLine(to: CGPoint(x: center.x - 5, y: center.y - 20))
//        arrowPath.addLine(to: CGPoint(x: center.x + 5, y: center.y - 20))
//        arrowPath.close()
//        arrowPath.fill()
//
//
//        // Малюємо напрямки
//        let font = UIFont.systemFont(ofSize: 12)
//        let attributes = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.white]
//        let directions: [String] = ["Сх", "Пд", "Зх", "Пн"]
//        let textRadius = radius - 30
//
//        for (index, direction) in directions.enumerated() {
//            let angle = CGFloat(index) * (.pi / 2)
//            let stringSize = (direction as NSString).size(withAttributes: attributes)
//            let stringCenter = CGPoint(x: center.x + cos(angle) * textRadius - stringSize.width / 2,
//                                       y: center.y + sin(angle) * textRadius - stringSize.height / 2)
//            (direction as NSString).draw(at: stringCenter, withAttributes: attributes)
//        }
//
//        UIColor.white.setFill()
//        let text = "Пн"
//        let textSize = (text as NSString).size(withAttributes: attributes)
//        let textCenter = CGPoint(x: center.x - textSize.width / 2, y: center.y - textSize.height / 2)
//        (text as NSString).draw(at: textCenter, withAttributes: attributes)
//    }
//}
