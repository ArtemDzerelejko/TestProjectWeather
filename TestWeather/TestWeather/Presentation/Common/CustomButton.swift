//
//  CustomButton.swift
//  TestWeather
//
//  Created by artem on 17.10.2023.
//

import Foundation
import UIKit

final class CustomButton: UIButton {
    
    private lazy var label = UILabel().with {
        $0.textColor = UIColor.white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    init(title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupButtonImage()
        setupLabel(title: title)
        setupShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

private extension CustomButton {
    func setupButtonImage() {
        let buttonImage = UIImage(resource: .button)
        setBackgroundImage(buttonImage, for: .normal)
    }
    
    func setupLabel(title: String) {
        label.text = title
        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 2
        clipsToBounds = false
    }
}
