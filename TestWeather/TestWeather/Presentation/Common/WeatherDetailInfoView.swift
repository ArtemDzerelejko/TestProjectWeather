//
//  SmallView.swift
//  TestWeather
//
//  Created by artem on 31.10.2023.
//

import Foundation
import UIKit

final class WeatherDetailInfoView: UIView {
    
    private lazy var mainStackView = UIStackView().with {
        $0.axis = .vertical
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var titleStackView = UIStackView().with {
        $0.axis = .horizontal
        $0.spacing = 5
    }
    
    private lazy var titleImageView = UIImageView().with {
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var titleLabel = UILabel().with {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        $0.numberOfLines = 0
        $0.textColor = .white
    }
    
    private lazy var numericalValueLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 25)
    }
    
    private lazy var descriptionTextLabel = UILabel().with {
        $0.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        $0.numberOfLines = 1
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(titleImageName: String, title: String, numeric: String, descriptionText: String) {
        super.init(frame: .zero)
        configureUI(titleImageName: titleImageName, title: title, numeric: numeric, descriptionText: descriptionText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension WeatherDetailInfoView {
    func configureUI(titleImageName: String, title: String, numeric: String, descriptionText: String) {
        setupMainView()
        setupMainStackView()
        setupTitleStackView()
        setupTitleImageView(titleImageName: titleImageName)
        setupTitleLabel(title: title)
        setupNumericalValueLabel(numeric: numeric)
        setupDescriptionTextLabel(descriptionText: descriptionText)
    }
    
    func setupMainView() {
        BlurredBackgroundViewHelper.setupBlurredBackground(for: self)
    }

    func setupMainStackView() {
        addSubview(mainStackView)

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    func setupTitleStackView() {
        mainStackView.addArrangedSubview(titleStackView)
    }

    func setupTitleImageView(titleImageName: String) {
        titleImageView.image = UIImage(systemName: titleImageName)
        titleStackView.addArrangedSubview(titleImageView)

        NSLayoutConstraint.activate([
            titleImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func setupTitleLabel(title: String) {
        titleLabel.text = title.uppercased()
        titleStackView.addArrangedSubview(titleLabel)
    }
    
    func setupNumericalValueLabel(numeric: String) {
        numericalValueLabel.text = numeric
        mainStackView.addArrangedSubview(numericalValueLabel)
    }
    
    func setupDescriptionTextLabel(descriptionText: String) {
        descriptionTextLabel.text = descriptionText
        mainStackView.addArrangedSubview(descriptionTextLabel)
        
        NSLayoutConstraint.activate([
            descriptionTextLabel.widthAnchor.constraint(equalTo: mainStackView.widthAnchor)
        ])
    }
}
