//
//  CustomLoaderView.swift
//  TestWeather
//
//  Created by artem on 17.10.2023.
//

import Foundation
import UIKit


final class CustomLoaderView: UIImageView {
    
    private enum Constans {
        static let rotationAnimationKey: String = "rotationAnimation"
        static let transformRotationKey: String = "transform.rotation.z"
    }
    
    init() {
        super.init(image: UIImage(systemName: Strings.sunMaxFill))
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        contentMode = .scaleAspectFit
        isHidden = true
        let imageSize = CGSize(width: 75, height: 75)
        tintColor = .white
        frame.size = imageSize
    }
    
    override func startAnimating() {
        isHidden = false
        rotate()
    }
    
    override func stopAnimating() {
        isHidden = true
        removeRotation()
    }
    
    private func rotate() {
        let rotation = CABasicAnimation(keyPath: Constans.transformRotationKey)
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        layer.add(rotation, forKey: Constans.rotationAnimationKey)
    }
    
    private func removeRotation() {
        layer.removeAnimation(forKey: Constans.rotationAnimationKey)
    }
}
