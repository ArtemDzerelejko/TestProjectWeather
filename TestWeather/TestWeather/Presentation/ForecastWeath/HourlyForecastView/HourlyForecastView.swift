//
//  HourlyForecastCell.swift
//  TestWeather
//
//  Created by artem on 26.10.2023.

import Foundation
import UIKit

class HourlyForecastView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let hourlyForecastWeatherLabel = UILabel()
    private let lineView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    private let hourlyForecastViewCell: String = "hourlyForecastViewCell"

    private let systemImages = ["cloud.sun", "sun.max", "moon", "cloud.rain", "cloud.bolt"]
    private let labelsTexts = ["Зараз", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()
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
        backgroundColor = .lightBlue
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func setupHourlyForecastWeatherLabel() {
        hourlyForecastWeatherLabel.text = Strings.hourlyWeatherForecast
        hourlyForecastWeatherLabel.font = UIFont.systemFont(ofSize: 15)
        hourlyForecastWeatherLabel.textColor = UIColor.white
        hourlyForecastWeatherLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hourlyForecastWeatherLabel)

        NSLayoutConstraint.activate([
            hourlyForecastWeatherLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            hourlyForecastWeatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
        ])
    }

    private func setupLine() {
        lineView.backgroundColor = .white
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: hourlyForecastWeatherLabel.bottomAnchor, constant: 3),
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.widthAnchor.constraint(equalTo: widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HourlyForecastViewCell.self, forCellWithReuseIdentifier: hourlyForecastViewCell)
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 3),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -3)
        ])
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labelsTexts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: hourlyForecastViewCell, for: indexPath) as! HourlyForecastViewCell

        let labelText = labelsTexts[indexPath.item]
        let imageName = systemImages.randomElement() ?? ""
        let temperature = "15"

        cell.configure(labelText: labelText, imageName: imageName, temperature: temperature)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 80)
    }
}
