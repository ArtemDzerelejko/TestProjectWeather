//
//  BigView.swift
//  TestWeather
//
//  Created by artem on 02.11.2023.
//

import Foundation
import UIKit

class WeatherInfoView: UIView {
    
    private enum WindType: String {
        case wind = "Вітер"
        case gusts = "Пориви"
    }
    
    private lazy var mainStackView = UIStackView().with {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 5
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var titleStackView = UIStackView().with {
        $0.alignment = .leading
        $0.axis = .horizontal
        $0.spacing = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var imageForTitle = UIImageView().with {
        $0.image = UIImage(systemName: "wind")
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var labelForTitle = UILabel().with {
        $0.text = Strings.wind
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let windView = WindView(numberWind: "7",
                                    windType: WindType.wind.rawValue)
    
    private lazy var divider = UIView().with {
        $0.backgroundColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let gustsOfWind = WindView(numberWind: "10",
                                       windType: WindType.gusts.rawValue)
    
    private let compassArrowView = WindIndicatorView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension WeatherInfoView {
    private func configureUI() {
        setupMainView()
        setupCompassArrowView()
        setupMainStackView()
    }
    
    private func setupMainView() {
        // Створення ефекту розмиття
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(blurView)

        // Задання фонового кольору (у вашому випадку сірий)
        backgroundColor = .clear

        
        // Задання прозорості та округлення кутів
        blurView.alpha = 0.8
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: topAnchor),
            blurView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            // Додайте обмеження висоти для розташування елементів відносно нижнього краю
            heightAnchor.constraint(equalToConstant: 160),
        ])
    }

    
    private func setupMainStackView() {
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150)
        ])
        setupTitleStackView()
        setupWindView()
        setupDivider()
        setupGustsOfWind()
    }
    
    private func setupCompassArrowView() {
        addSubview(compassArrowView)
        compassArrowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            compassArrowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            compassArrowView.centerYAnchor.constraint(equalTo: centerYAnchor),
            compassArrowView.widthAnchor.constraint(equalToConstant: 170),
            compassArrowView.heightAnchor.constraint(equalToConstant: 170)
        ])
    }
}

// MARK: - setupTitleStackViewА що
extension WeatherInfoView {
    private func setupTitleStackView() {
        mainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(imageForTitle)
        titleStackView.addArrangedSubview(labelForTitle)
    }
}

// MARK: - setupWindView
extension WeatherInfoView {
    private func setupWindView() {
        mainStackView.addArrangedSubview(windView)
        
        NSLayoutConstraint.activate([
            windView.heightAnchor.constraint(equalToConstant: 50),
            windView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -30),
        ])
    }
}

// MARK: - setup divider
extension WeatherInfoView {
    private func setupDivider() {
        mainStackView.addArrangedSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}

// MARK: - setupGustsOfWind
extension WeatherInfoView  {
    private func setupGustsOfWind() {
        mainStackView.addArrangedSubview(gustsOfWind)
        
        NSLayoutConstraint.activate([
            gustsOfWind.heightAnchor.constraint(equalToConstant: 50),
            gustsOfWind.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -30),
        ])
    }
}
