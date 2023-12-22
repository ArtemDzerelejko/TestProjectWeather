//
//  HourlyForecastViewCell.swift
//  TestWeather
//
//  Created by artem on 30.10.2023.
//

import Foundation
import UIKit

final class HourlyForecastViewCell: UICollectionViewCell {
    
    private lazy var firstLabel = UILabel().with {
        $0.textAlignment = .center
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var secondLabel = UIImageView().with {
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var thirdLabel = UILabel().with {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    static let forecastCellIdentifier = Keys.forecastWeatherCell
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HourlyForecastViewCell {
    private func setupViews() {
        setupFirstLabel()
        setupSecondLabel()
        setupThirdLabel()
    }
    
    private func setupFirstLabel() {
        addSubview(firstLabel)
        
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            firstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
    private func setupSecondLabel() {
        addSubview(secondLabel)
        
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5),
            secondLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupThirdLabel() {
        addSubview(thirdLabel)
        
        NSLayoutConstraint.activate([
            thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 5),
            thirdLabel.centerXAnchor.constraint(equalTo: secondLabel.centerXAnchor),
            thirdLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configure(labelText: String, imageName: String, temperature: String) {
        firstLabel.text = labelText
        secondLabel.image = UIImage(systemName: imageName)
        thirdLabel.text = temperature
    }
}
