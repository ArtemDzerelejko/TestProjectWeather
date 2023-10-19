//
//  GradientBackgroundView.swift
//  TestWeather
//
//  Created by artem on 12.10.2023.
//

import Foundation
import UIKit

final class GradientBackgroundView: UIView {
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - configure gradient

private extension GradientBackgroundView {
    func configureGradientLayer() {
        guard let gradientLayer = layer as? CAGradientLayer else {return}
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemYellow.cgColor]
        gradientLayer.locations = [0.0, 1.0]
    }
}
