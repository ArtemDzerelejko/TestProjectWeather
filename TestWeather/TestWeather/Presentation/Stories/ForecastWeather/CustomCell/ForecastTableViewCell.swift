//
//  ForecastTableViewCell.swift
//  TestWeather
//
//  Created by artem on 18.10.2023.
//

import Foundation
import UIKit

class ForecastTableViewCell: UITableViewCell {
    var containerView = UIView()
    var dateLabel = CustomLabel(textColor: .black, fontSize: 16)
    var maxTempLabel = CustomLabel(textColor: .black, fontSize: 14)
    var minTempLabel = CustomLabel(textColor: .black, fontSize: 14)
    var chanceOfRainLabel = CustomLabel(textColor: .black, fontSize: 14)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension ForecastTableViewCell {
    func configureUI() {
        setupContainerView()
        setupDateLabel()
        setupMaxTempLabel()
        setupMixTempLabel()
        setupChanceOfRainLabel()
    }
    
    func setupContainerView() {
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 20
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60)
        ])
    }
    
    func setupDateLabel() {
        containerView.addSubview(dateLabel)
        dateLabel.textColor = .black
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
    }
    
    func setupMaxTempLabel() {
        containerView.addSubview(maxTempLabel)
        maxTempLabel.textColor = .black
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maxTempLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 10),
            maxTempLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    func setupMixTempLabel() {
        containerView.addSubview(minTempLabel)
        minTempLabel.textColor = .black
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minTempLabel.topAnchor.constraint(equalTo: maxTempLabel.bottomAnchor, constant: 3),
            minTempLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
    
    func setupChanceOfRainLabel() {
        containerView.addSubview(chanceOfRainLabel)
        chanceOfRainLabel.textColor = .black
        chanceOfRainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chanceOfRainLabel.topAnchor.constraint(equalTo: minTempLabel.bottomAnchor, constant: 3),
            chanceOfRainLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }
}
