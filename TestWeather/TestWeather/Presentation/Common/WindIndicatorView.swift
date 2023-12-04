//
//  CompassArrowView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

//import UIKit
//import CoreMotion
//
//class WindIndicatorView: UIImageView {
//    
//    private static var sharedHourlyWindUpdateTimer: Timer?
//    private let windDirectionKey = "WindDirectionKey"
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configure()
//        loadSavedWindDirection()
//        startHourlyWindUpdateTimer()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        configure()
//        loadSavedWindDirection()
//        startHourlyWindUpdateTimer()
//    }
//    
//    deinit {
//        stopHourlyWindUpdateTimer()
//    }
//}
//
//// MARK: - UI
//extension WindIndicatorView {
//    private func configure() {
//        image = UIImage(systemName: "arrow.up")
//        contentMode = .scaleAspectFit
//        self.tintColor = .blue
//    }
//    
//    private func startHourlyWindUpdateTimer() {
//        if WindIndicatorView.sharedHourlyWindUpdateTimer == nil {
//            WindIndicatorView.sharedHourlyWindUpdateTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.updateWindDirection), userInfo: nil, repeats: true)
//        }
//    }
//    
//    private func generateRandomWindDirection() -> Double {
//        Double.random(in: 0...360)
//    }
//    
//    private func rotateArrowTo(direction: Double) {
//        UIView.animate(withDuration: 1.0) {
//            let rotationAngle = CGFloat(direction).truncatingRemainder(dividingBy: 360)
//            self.transform = CGAffineTransform(rotationAngle: rotationAngle.toRadians())
//        }
//    }
//    
//    private func loadSavedWindDirection() {
//        if let savedWindDirection = UserDefaults.standard.value(forKey: windDirectionKey) as? Double {
//            rotateArrowTo(direction: savedWindDirection)
//        }
//    }
//    
//    private func stopHourlyWindUpdateTimer() {
//        WindIndicatorView.sharedHourlyWindUpdateTimer?.invalidate()
//        WindIndicatorView.sharedHourlyWindUpdateTimer = nil
//    }
//}
//
//// MARK: - Action
//extension WindIndicatorView {
//    @objc private func updateWindDirection() {
//        let newWindDirection = generateRandomWindDirection()
//        rotateArrowTo(direction: newWindDirection)
//        UserDefaults.standard.set(newWindDirection, forKey: windDirectionKey)
//    }
//}

import UIKit
import CoreMotion

class WindIndicatorView: UIView {
    
    private static var sharedHourlyWindUpdateTimer: Timer?
    private let windDirectionKey = "WindDirectionKey"
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .wind) // Встановіть фоновий образ за вашим вибором
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.north.line")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        loadSavedWindDirection()
        startHourlyWindUpdateTimer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
        loadSavedWindDirection()
        startHourlyWindUpdateTimer()
    }
    
    deinit {
        stopHourlyWindUpdateTimer()
    }
}

// MARK: - UI
extension WindIndicatorView {
    private func configure() {
        addSubview(backgroundImageView)
        addSubview(arrowImageView)
        
        // Додайте обмеження для обидвох підвидів
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            arrowImageView.centerXAnchor.constraint(equalTo: backgroundImageView.centerXAnchor, constant: -9),
            arrowImageView.centerYAnchor.constraint(equalTo: backgroundImageView.centerYAnchor),
            arrowImageView.heightAnchor.constraint(equalToConstant: 30),
            arrowImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
        
        sendSubviewToBack(backgroundImageView)
    }
    
    private func startHourlyWindUpdateTimer() {
        if WindIndicatorView.sharedHourlyWindUpdateTimer == nil {
            WindIndicatorView.sharedHourlyWindUpdateTimer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(self.updateWindDirection), userInfo: nil, repeats: true)
        }
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
        UserDefaults.standard.set(newWindDirection, forKey: windDirectionKey)
    }
}
