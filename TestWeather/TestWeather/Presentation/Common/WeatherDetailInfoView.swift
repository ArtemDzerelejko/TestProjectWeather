//
//  SmallView.swift
//  TestWeather
//
//  Created by artem on 31.10.2023.
//

import Foundation
import UIKit

class WeatherDetailInfoView: UIView {
    
    private let mainStackView = UIStackView()
    private let titleStackView = UIStackView()
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let numericalValueLabel = UILabel()
    private let descriptionTextLabel = UILabel()
    
    init(titleImageName: String, title: String, numeric: String, descriptionText: String) {
        super.init(frame: .zero)
        configureUI(titleImageName: titleImageName, title: title, numeric: numeric, descriptionText: descriptionText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherDetailInfoView {
    private func configureUI(titleImageName: String, title: String, numeric: String, descriptionText: String) {
        setupMainView()
        setupMainStackView()
        setupTitleStackView()
        setupTitleImageView(titleImageName: titleImageName)
        setupTitleLabel(title: title)
        setupNumericalValueLabel(numeric: numeric)
        setupDescriptionTextLabel(descriptionText: descriptionText)
        
    }
    
    private func setupMainView() {
        BlurredBackgroundViewHelper.setupBlurredBackground(for: self)
    }

    private func setupMainStackView() {
        mainStackView.axis = .vertical
        mainStackView.spacing = 5
        addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func setupTitleStackView() {
        titleStackView.axis = .horizontal
        titleStackView.spacing = 5
        mainStackView.addArrangedSubview(titleStackView)
    }

    
    private func setupTitleImageView(titleImageName: String) {
        titleImageView.image = UIImage(systemName: titleImageName)
        titleImageView.tintColor = .white
        titleStackView.addArrangedSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupTitleLabel(title: String) {
        titleLabel.text = title.uppercased()
        titleLabel.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupNumericalValueLabel(numeric: String) {
        numericalValueLabel.text = numeric
        numericalValueLabel.textColor = .white
        numericalValueLabel.font = UIFont.systemFont(ofSize: 25)
        mainStackView.addArrangedSubview(numericalValueLabel)
    }
    
    private func setupDescriptionTextLabel(descriptionText: String) {
        descriptionTextLabel.text = descriptionText
        descriptionTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        descriptionTextLabel.numberOfLines = 1
        descriptionTextLabel.textColor = .white
        mainStackView.addArrangedSubview(descriptionTextLabel)
        descriptionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
}
