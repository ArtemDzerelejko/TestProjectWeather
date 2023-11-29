//
//  StackViewForWind.swift
//  TestWeather
//
//  Created by artem on 06.11.2023.
//

import Foundation
import UIKit

class WindStackView: UIView {
    
    private lazy var stackView = UIStackView().with {
        $0.axis = .vertical
        $0.spacing = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var unitsOfMeasurement = UILabel().with {
        $0.textColor = .gray
    }
    
    private lazy var windInfo = UILabel().with {
        $0.textColor = .white
    }
    
    init(unitsOfMeasurementText: String, windInfoText: String) {
        super.init(frame: .zero)
        configureUI(unitsOfMeasurementText: unitsOfMeasurementText, windInfoText: windInfoText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WindStackView {
    private func configureUI(unitsOfMeasurementText: String, windInfoText: String) {
        setupStackView()
        setupUnitsOfMeasurement(unitsOfMeasurementText: unitsOfMeasurementText)
        setupWindInfo(windInfoText: windInfoText)
    }
    
    private func setupStackView() {
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupUnitsOfMeasurement(unitsOfMeasurementText: String) {
        unitsOfMeasurement.text = unitsOfMeasurementText
        stackView.addArrangedSubview(unitsOfMeasurement)
    }
    
    private func setupWindInfo(windInfoText: String) {
        windInfo.text = windInfoText
        stackView.addArrangedSubview(windInfo)
    }
}
