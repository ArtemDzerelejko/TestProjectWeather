//
//  CompassArrowView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import UIKit
import CoreMotion

class WindIndicatorView: UIView {
    
    private static var sharedHourlyWindUpdateTimer: Timer?
    
    private lazy var backgroundImageView = UIImageView().with {
        $0.image = UIImage(resource: .windCompass)
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private lazy var arrowImageView = UIImageView().with {
        $0.image = UIImage(systemName: Strings.locationNorth)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .white
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        loadSavedWindDirection()
        startHourlyWindUpdateTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        stopHourlyWindUpdateTimer()
    }
}

// MARK: - UI

extension WindIndicatorView {
    private func configure() {
        setupBackgroundImageView()
        setupArrowImageView()
    }
    
    private func setupBackgroundImageView() {
        addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 120),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 120)
        ])
        sendSubviewToBack(backgroundImageView)
    }
    
    private func setupArrowImageView() {
        addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor, constant: 3),
            arrowImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 25),
            arrowImageView.widthAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    private func generateRandomWindDirection() -> Double {
        Double.random(in: 0...360)
    }
    
    private func rotateArrowTo(direction: Double) {
        UIView.animate(withDuration: 1.0) {
            let rotationAngle = CGFloat(direction).truncatingRemainder(dividingBy: 360)
            self.arrowImageView.transform = CGAffineTransform(rotationAngle: rotationAngle.toRadians())
        }
    }
    
    private func loadSavedWindDirection() {
        if let savedWindDirection = UserDefaults.standard.value(forKey: Keys.windDirection) as? Double {
            rotateArrowTo(direction: savedWindDirection)
        }
    }
}

// MARK: - Action

extension WindIndicatorView {
    @objc private func updateWindDirection() {
        let newWindDirection = generateRandomWindDirection()
        rotateArrowTo(direction: newWindDirection)
        UserDefaults.standard.set(newWindDirection, forKey: Keys.windDirection)
    }
}

// MARK: - setup Timer

extension WindIndicatorView {
    private func startHourlyWindUpdateTimer() {
        if WindIndicatorView.sharedHourlyWindUpdateTimer == nil {
            WindIndicatorView.sharedHourlyWindUpdateTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.updateWindDirection), userInfo: nil, repeats: true)
        }
    }
    
    private func stopHourlyWindUpdateTimer() {
        WindIndicatorView.sharedHourlyWindUpdateTimer?.invalidate()
        WindIndicatorView.sharedHourlyWindUpdateTimer = nil
    }
}
