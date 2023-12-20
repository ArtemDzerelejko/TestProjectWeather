//
//  СityTimeStackView.swift
//  TestWeather
//
//  Created by artem on 19.12.2023.
//

import UIKit

class СityTimeStackView: UIStackView {
    
    private lazy var cityLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var timeLabel = UILabel().with {
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(city: String, time: String) {
        super.init(frame: .zero)
        configureUI(city: city, time: time)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - setupUI
private extension СityTimeStackView {
    func configureUI(city: String, time: String) {
        setupСityTimeStackView()
        setupCityLabel(city: city)
        setupTimeLabel(time: time)
    }
    
    func setupСityTimeStackView() {
        axis = .vertical
        spacing = 2
        alignment = .leading
        layer.cornerRadius = 5
    }
    
    func setupCityLabel(city: String) {
        cityLabel.text = city
        addArrangedSubview(cityLabel)
    }
    
    func setupTimeLabel(time: String) {
        timeLabel.text = time
        addArrangedSubview(timeLabel)
    }
}
