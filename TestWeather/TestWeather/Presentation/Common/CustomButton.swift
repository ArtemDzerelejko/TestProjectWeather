//
//  CustomButton.swift
//  TestWeather
//
//  Created by artem on 17.10.2023.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    private let label = UILabel()
    
    init(title: String) {
        super.init(frame: .zero)
        setupButtonImage()
        setupLabel(title: title)
        setupShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension CustomButton {
    private func setupButtonImage() {
        let buttonImage = UIImage(resource: .button)
        setBackgroundImage(buttonImage, for: .normal)
    }
    
    private func setupLabel(title: String) {
        label.text = title
        label.textColor = UIColor.white
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 2
        clipsToBounds = false
    }
}
