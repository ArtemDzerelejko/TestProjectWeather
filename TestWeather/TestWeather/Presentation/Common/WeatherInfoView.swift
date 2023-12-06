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
        $0.image = UIImage(systemName: Strings.windImage)
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
    
    private let divider = DividerView()
    
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
        BlurredBackgroundViewHelper.setupBlurredBackground(for: self)
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
    
    private func setupTitleStackView() {
        mainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(imageForTitle)
        titleStackView.addArrangedSubview(labelForTitle)
    }
    
    private func setupWindView() {
        mainStackView.addArrangedSubview(windView)
        
        NSLayoutConstraint.activate([
            windView.heightAnchor.constraint(equalToConstant: 50),
            windView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -30),
        ])
    }
    
    private func setupDivider() {
        mainStackView.addArrangedSubview(divider)
        
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalTo: mainStackView.widthAnchor),
        ])
    }
    
    private func setupGustsOfWind() {
        mainStackView.addArrangedSubview(gustsOfWind)
        
        NSLayoutConstraint.activate([
            gustsOfWind.heightAnchor.constraint(equalToConstant: 50),
            gustsOfWind.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: -30),
        ])
    }
}
