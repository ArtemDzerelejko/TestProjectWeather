//
//  WindView.swift
//  TestWeather
//
//  Created by artem on 30.11.2023.
//

import UIKit

class WindView: UIView {
    
    private lazy var numberForWind = UILabel().with {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.boldSystemFont(ofSize: 30)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var horizontalStackView = UIStackView().with {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var unitOfMeasurementForGustsOfWind = UILabel().with {
        $0.text = Strings.unitsOfMeasurement
        $0.textColor = .white
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var windTypeLabel = UILabel().with {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(numberWind: String, windType: String) {
        super.init(frame: .zero)
        configure(numberWind: numberWind, windType: windType)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension WindView {
    private func configure(numberWind: String, windType: String) {
        setupNumberForWind(numberWind: numberWind)
        setupHorizontalStackView(windType: windType)
    }
    
    private func setupNumberForWind(numberWind: String) {
        numberForWind.text = numberWind
        addSubview(numberForWind)
        
        NSLayoutConstraint.activate([
            numberForWind.topAnchor.constraint(equalTo: topAnchor),
            numberForWind.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberForWind.bottomAnchor.constraint(equalTo: bottomAnchor),
            numberForWind.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupHorizontalStackView(windType: String) {
        addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: numberForWind.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: numberForWind.trailingAnchor, constant: 5),
        ])
        horizontalStackView.addArrangedSubview(unitOfMeasurementForGustsOfWind)
        setupWindType(windType: windType)
    }
    
    private func setupWindType(windType: String) {
        windTypeLabel.text = windType
        horizontalStackView.addArrangedSubview(windTypeLabel)
    }
}
