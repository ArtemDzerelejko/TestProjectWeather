//
//  ParametersOfTheQuarter.swift
//  TestWeather
//
//  Created by artem on 01.12.2023.
//

import UIKit

final class ParametersOfTheQuarter: UIView {
    
    private lazy var parametersLabel = UILabel().with {
        $0.textAlignment = .left
        $0.textColor = .white
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var numericalParametersLabel = UILabel().with {
        $0.text = "57 %"
        $0.textAlignment = .center
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(parameter: String, numParameters: String) {
        super.init(frame: .zero)
        configure(parameter: parameter, numParameters: numParameters)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension ParametersOfTheQuarter {
    func configure(parameter: String, numParameters: String) {
        setupParametersLabel(parameter: parameter)
        setupNumericalParametersLabel(numParameters: numParameters)
    }
    
    func setupParametersLabel(parameter: String) {
        parametersLabel.text = parameter
        addSubview(parametersLabel)
        
        NSLayoutConstraint.activate([
            parametersLabel.topAnchor.constraint(equalTo: topAnchor),
            parametersLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            parametersLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupNumericalParametersLabel(numParameters: String) {
        numericalParametersLabel.text = numParameters
        addSubview(numericalParametersLabel)
        
        NSLayoutConstraint.activate([
            numericalParametersLabel.topAnchor.constraint(equalTo: parametersLabel.topAnchor),
            numericalParametersLabel.leadingAnchor.constraint(equalTo: parametersLabel.trailingAnchor, constant: 20),
            numericalParametersLabel.bottomAnchor.constraint(equalTo: parametersLabel.bottomAnchor)
        ])
    }
}
