//
//  CompassArrowView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import UIKit
import CoreMotion

class WindIndicatorView: UIImageView {
    
    private static var sharedHourlyWindUpdateTimer: Timer?
    private let windDirectionKey = "WindDirectionKey"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        startHourlyWindUpdateTimer()
        loadSavedWindDirection()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        startHourlyWindUpdateTimer()
        loadSavedWindDirection()
    }
    
    deinit {
        stopHourlyWindUpdateTimer()
    }
}

// MARK: - UI
extension WindIndicatorView {
    private func configure() {
        image = UIImage(systemName: "arrow.up")
        contentMode = .scaleAspectFit
        self.tintColor = .blue
        updateWindDirection()
    }
    
    private func startHourlyWindUpdateTimer() {
        if WindIndicatorView.sharedHourlyWindUpdateTimer == nil {
            WindIndicatorView.sharedHourlyWindUpdateTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(updateWindDirection), userInfo: nil, repeats: true)
        }
    }
    
    private func generateRandomWindDirection() -> Double {
        return Double.random(in: 0...360)
    }
    
    private func rotateArrowTo(direction: Double) {
        UIView.animate(withDuration: 1.0) {
            let rotationAngle = CGFloat(direction).truncatingRemainder(dividingBy: 360)
            self.transform = CGAffineTransform(rotationAngle: rotationAngle.toRadians())
        }
        
        // Save the wind direction to UserDefaults
        UserDefaults.standard.set(direction, forKey: windDirectionKey)
    }
    
    private func loadSavedWindDirection() {
        if let savedWindDirection = UserDefaults.standard.value(forKey: windDirectionKey) as? Double {
            rotateArrowTo(direction: savedWindDirection)
        }
    }
    
    private func stopHourlyWindUpdateTimer() {
        WindIndicatorView.sharedHourlyWindUpdateTimer?.invalidate()
        WindIndicatorView.sharedHourlyWindUpdateTimer = nil
    }
}

// MARK: - Action
extension WindIndicatorView {
    @objc private func updateWindDirection() {
        let newWindDirection = generateRandomWindDirection()
        rotateArrowTo(direction: newWindDirection)
    }
}
