//
//  TemperatureInfo.swift
//  TestWeather
//
//  Created by artem on 06.12.2023.
//

import UIKit

final class TemperatureInfo: UIView {
    
    private lazy var horizontalStackView = UIStackView().with {
        $0.axis = .horizontal
        $0.spacing = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var temperatureInfoLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }
    
    private lazy var temperatureNumberLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 20, weight: .light)
    }
    
    init(temperatureInfo: String, temperatureNumber: String) {
        super.init(frame: .zero)
        configureUI(temperatureInfo: temperatureInfo, temperatureNumber: temperatureNumber)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension TemperatureInfo {
    func configureUI(temperatureInfo: String, temperatureNumber: String) {
        setupTemperatureInfoLabel(temperatureInfo: temperatureInfo)
        setupTemperatureNumberLabel(temperatureNumber: temperatureNumber)
        setupHorizontalStackView()
    }
    
    func setupTemperatureInfoLabel(temperatureInfo: String) {
        temperatureInfoLabel.text = temperatureInfo
    }
    
    func setupTemperatureNumberLabel(temperatureNumber: String) {
        temperatureNumberLabel.text = temperatureNumber
    }
    
    func setupHorizontalStackView() {
        addSubview(horizontalStackView)
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        horizontalStackView.addArrangedSubview(temperatureInfoLabel)
        horizontalStackView.addArrangedSubview(temperatureNumberLabel)
    }
}
