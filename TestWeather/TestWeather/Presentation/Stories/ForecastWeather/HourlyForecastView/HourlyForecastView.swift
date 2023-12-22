//
//  HourlyForecastCell.swift
//  TestWeather
//
//  Created by artem on 26.10.2023.

import Foundation
import UIKit

class HourlyForecastView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private lazy var hourlyForecastWeatherLabel = UILabel().with {
        $0.text = Strings.hourlyWeatherForecast
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = UIColor.white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var lineView = UIView().with {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var layout = UICollectionViewFlowLayout().with {
        $0.scrollDirection = .horizontal
    }
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).with {
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
        $0.delegate = self
        $0.dataSource = self
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let viewModel = ForecastWeatherViewModel(country: Strings.ukraine)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
        translatesAutoresizingMaskIntoConstraints = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setupHourlyForecastWeatherView()
        setupHourlyForecastWeatherLabel()
        setupLine()
        setupCollectionView()
    }

    private func setupHourlyForecastWeatherView() {
        BlurredBackgroundViewHelper.setupBlurredBackground(for: self)
    }

    private func setupHourlyForecastWeatherLabel() {
        addSubview(hourlyForecastWeatherLabel)

        NSLayoutConstraint.activate([
            hourlyForecastWeatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            hourlyForecastWeatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }

    private func setupLine() {
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: hourlyForecastWeatherLabel.bottomAnchor, constant: 3),
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.widthAnchor.constraint(equalTo: widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func setupCollectionView() {
        collectionView.register(HourlyForecastViewCell.self, forCellWithReuseIdentifier: HourlyForecastViewCell.forecastCellIdentifier)
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 3),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.labelsTexts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastViewCell.forecastCellIdentifier, for: indexPath) as! HourlyForecastViewCell

        let labelText = viewModel.labelsTexts[indexPath.item]
        let imageName = viewModel.systemImagesForHourlyForecastView.randomElement() ?? ""
        let temperature = "15"
        cell.configure(labelText: labelText, imageName: imageName, temperature: temperature)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 80)
    }
}
