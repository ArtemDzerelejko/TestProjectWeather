//
//  WindView.swift
//  TestWeather
//
//  Created by artem on 30.11.2023.
//

import UIKit

final class WindView: UIView {
    
    private lazy var numberForWindLabel = UILabel().with {
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
    
    private lazy var unitOfMeasurementForGustsOfWindLabel = UILabel().with {
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

private extension WindView {
    func configure(numberWind: String, windType: String) {
        setupNumberForWindLabel(numberWind: numberWind)
        setupHorizontalStackView(windType: windType)
    }
    
    func setupNumberForWindLabel(numberWind: String) {
        numberForWindLabel.text = numberWind
        addSubview(numberForWindLabel)
        
        NSLayoutConstraint.activate([
            numberForWindLabel.topAnchor.constraint(equalTo: topAnchor),
            numberForWindLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            numberForWindLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            numberForWindLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setupHorizontalStackView(windType: String) {
        addSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: numberForWindLabel.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: numberForWindLabel.trailingAnchor, constant: 5),
        ])
        horizontalStackView.addArrangedSubview(unitOfMeasurementForGustsOfWindLabel)
        setupWindType(windType: windType)
    }
    
    func setupWindType(windType: String) {
        windTypeLabel.text = windType
        horizontalStackView.addArrangedSubview(windTypeLabel)
    }
}
