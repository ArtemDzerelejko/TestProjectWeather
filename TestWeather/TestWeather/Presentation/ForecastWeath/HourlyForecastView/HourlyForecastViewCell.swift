//
//  HourlyForecastViewCell.swift
//  TestWeather
//
//  Created by artem on 30.10.2023.
//

import Foundation
import UIKit

class HourlyForecastViewCell: UICollectionViewCell {
    private let firstLabel = UILabel()
    private let secondLabel = UIImageView()
    private let thirdLabel = UILabel()
    
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
        firstLabel.textAlignment = .center
        firstLabel.numberOfLines = 0
        addSubview(firstLabel)
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            firstLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
    
    private func setupSecondLabel() {
        secondLabel.tintColor = .white
        addSubview(secondLabel)
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 5),
            secondLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupThirdLabel() {
        thirdLabel.numberOfLines = 0
        addSubview(thirdLabel)
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
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
