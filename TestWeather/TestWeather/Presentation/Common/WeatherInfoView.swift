//
//  BigView.swift
//  TestWeather
//
//  Created by artem on 02.11.2023.
//

import Foundation
import UIKit

class WeatherInfoView: UIView {
    
    private lazy var mainStackView = UIStackView().with {
        $0.backgroundColor = .red
        $0.axis = .vertical
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var headerStackView = UIStackView().with {
        $0.backgroundColor = .green
        $0.axis = .horizontal
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    private lazy var headerTitleImageView = UIImageView().with {
        $0.tintColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var headerTitleLabel = UILabel().with {
        $0.font = UIFont.systemFont(ofSize: 10)
        $0.textColor = .gray
        $0.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private lazy var numericalValuesLabelForWind = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 30)
    }
    
    private lazy var dividingLine = UIView().with {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var numericalValuesLabelGustsOfWind = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 30)
    }
    
    private let stackViewForWeather = WindStackView(unitsOfMeasurementText: "м/c", windInfoText: Strings.wind)
    
    init(headerImageName: String, headerText: String, numericalValuesLabelForWind: String, numericalValuesLabelGustsOfWind: String) {
        super.init(frame: .zero)
        configureUI(headerImageName: headerImageName, headerText: headerText, numericalValuesLabelForWind: numericalValuesLabelForWind, numericalValuesLabelGustsOfWind: numericalValuesLabelGustsOfWind)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherInfoView {
    private func configureUI(headerImageName: String, headerText: String, numericalValuesLabelForWind: String, numericalValuesLabelGustsOfWind: String) {
        setupMainView()
        setupMainStackView()
        setupHeaderStackView()
        setupHeaderImageView(headerImageName: headerImageName)
        setupHeaderLabel(headerLabel: headerText)
        setupNumericalValuesLabelForWind(numericalValuesForWind: numericalValuesLabelForWind)
        setupDividingLine()
        setupNumericalValuesLabelGustsOfWind(numericalValuesGustsOfWind: numericalValuesLabelGustsOfWind)
    }
    
    private func setupMainView() {
        backgroundColor = .lightBlue
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupMainStackView() {
        addSubview(mainStackView)
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])
    }
    
    private func setupHeaderStackView() {
        mainStackView.addArrangedSubview(headerStackView)
    }
    
    private func setupHeaderImageView(headerImageName: String) {
        headerTitleImageView.image = UIImage(systemName: headerImageName)
        headerStackView.addArrangedSubview(headerTitleImageView)
        NSLayoutConstraint.activate([
            headerTitleImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupHeaderLabel(headerLabel: String) {
        headerTitleLabel.text = headerLabel.uppercased()
        headerStackView.addArrangedSubview(headerTitleLabel)
    }
    
    private func setupNumericalValuesLabelForWind(numericalValuesForWind: String) {
        numericalValuesLabelForWind.text = numericalValuesForWind
        mainStackView.addArrangedSubview(numericalValuesLabelForWind)
    }
    
    private func setupDividingLine() {
        mainStackView.addArrangedSubview(dividingLine)
        NSLayoutConstraint.activate([
            dividingLine.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
    
    private func setupNumericalValuesLabelGustsOfWind(numericalValuesGustsOfWind: String) {
        numericalValuesLabelGustsOfWind.text = numericalValuesGustsOfWind
        mainStackView.addArrangedSubview(numericalValuesLabelGustsOfWind)
    }
}
