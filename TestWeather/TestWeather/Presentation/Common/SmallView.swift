//
//  SmallView.swift
//  TestWeather
//
//  Created by artem on 31.10.2023.
//

import Foundation
import UIKit

class SmallView: UIView {
    
    private let titleView = UIView()
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    private let numericalValueLabel = UILabel()
    private let descriptionTextLabel = UILabel()
    
    init(titleImage: String, title: String, numeric: String, descriptionText: String) {
        super.init(frame: .zero)
        configureUI(titleImage: titleImage, title: title, numeric: numeric, descriptionText: descriptionText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SmallView {
    private func configureUI(titleImage: String, title: String, numeric: String, descriptionText: String) {
        setupMainView()
        setupTitleView()
        setupTitleImageView(titleImage: titleImage)
        setupTitleLabel(title: title)
        setupNumericalValueLabel(numeric: numeric)
        setupDescriptionTextLabel(descriptionText: descriptionText)
    }
    
    private func setupMainView() {
        backgroundColor = .lightBlue
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupTitleView() {
        addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleView.heightAnchor.constraint(equalToConstant: 20),
            titleView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    private func setupTitleImageView(titleImage: String) {
        titleImageView.image = UIImage(systemName: titleImage)
        titleImageView.tintColor = .gray
        titleView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor, constant: 5),
            titleImageView.heightAnchor.constraint(equalToConstant: 18),
            titleImageView.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    private func setupTitleLabel(title: String) {
        titleLabel.text = title.uppercased()
        titleLabel.font = UIFont.systemFont(ofSize: 10)
        titleLabel.textColor = .gray
        titleView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: titleImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: 2),
        ])
    }
    
    private func setupNumericalValueLabel(numeric: String) {
        numericalValueLabel.text = numeric
        numericalValueLabel.textColor = .white
        numericalValueLabel.font = UIFont.systemFont(ofSize: 25)
        addSubview(numericalValueLabel)
        numericalValueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            numericalValueLabel.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 3),
            numericalValueLabel.leadingAnchor.constraint(equalTo: titleImageView.leadingAnchor)
        ])
    }
    
    private func setupDescriptionTextLabel(descriptionText: String) {
        descriptionTextLabel.text = descriptionText
        descriptionTextLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        descriptionTextLabel.numberOfLines = 0
        descriptionTextLabel.textColor = .white
        addSubview(descriptionTextLabel)
        descriptionTextLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionTextLabel.topAnchor.constraint(equalTo: numericalValueLabel.bottomAnchor, constant: 3),
            descriptionTextLabel.leadingAnchor.constraint(equalTo: titleImageView.leadingAnchor),
            descriptionTextLabel.widthAnchor.constraint(equalTo: titleView.widthAnchor)
        ])
    }
}
