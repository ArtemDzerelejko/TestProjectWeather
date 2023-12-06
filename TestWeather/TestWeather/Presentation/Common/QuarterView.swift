//
//  QuarterView.swift
//  TestWeather
//
//  Created by artem on 01.12.2023.
//

import UIKit

class QuarterView: UIView {
    
    private lazy var mainStackView = UIStackView().with {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 7
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var moonImageView = UIImageView().with {
        $0.image = UIImage(resource: .moon)
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var titleStackView = UIStackView().with {
        $0.alignment = .leading
        $0.axis = .horizontal
        $0.spacing = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var imageForTitle = UIImageView().with {
        $0.image = UIImage(systemName: Strings.moonphaseWaxingCrescent)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var labelForTitle = UILabel().with {
        $0.text = Strings.thirdQuarter
        $0.textColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let dividerViewFirst = DividerView()
    private let dividerViewSecond = DividerView()
    
    private let lightParametersOfTheQuarter = ParametersOfTheQuarter(parameter: Strings.light, numParameters: "57%")
    private let moonRiseParametersOfTheQuarter = ParametersOfTheQuarter(parameter: Strings.moonrise, numParameters: "22:57")
    private let nextFullMoonParametersOfTheQuarter = ParametersOfTheQuarter(parameter: Strings.nextFullMoon, numParameters: "23 дн.")
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension QuarterView {
    private func configureUI() {
        setupMainView()
        setupMoonImageView()
        setupMainStackView()
    }
    
    private func setupMainView() {
        BlurredBackgroundViewHelper.setupBlurredBackground(for: self)
    }
    
    // MARK: - setupMainStackView
    private func setupMainStackView() {
        addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -120)
        ])
        setupTitleStackView()
        setupParametersofTheQuarter()
    }
    
    private func setupMoonImageView() {
        addSubview(moonImageView)
        
        NSLayoutConstraint.activate([
            
            moonImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            moonImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            moonImageView.widthAnchor.constraint(equalToConstant: 100),
            moonImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - setupTitleStackView
    private func setupTitleStackView() {
        mainStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(imageForTitle)
        titleStackView.addArrangedSubview(labelForTitle)
    }
    
    private func setupParametersofTheQuarter() {
        mainStackView.addArrangedSubview(lightParametersOfTheQuarter)
        mainStackView.addArrangedSubview(dividerViewFirst)
        dividerViewFirst.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        mainStackView.addArrangedSubview(moonRiseParametersOfTheQuarter)
        mainStackView.addArrangedSubview(dividerViewSecond)
        dividerViewSecond.widthAnchor.constraint(equalTo: mainStackView.widthAnchor).isActive = true
        mainStackView.addArrangedSubview(nextFullMoonParametersOfTheQuarter)
    }
}
