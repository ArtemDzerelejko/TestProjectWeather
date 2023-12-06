//
//  CompassView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import UIKit
import CoreMotion

class CompassView: UIView {
    
    private var motionManager = CMMotionManager()
    
    private lazy var backgroundImageView = UIImageView().with {
        $0.image = UIImage(resource: .compass)
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
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
        configureUI()
        configureMotionManager()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension CompassView {
    private func configureUI() {
        setupBackgroundImageView()
        setupArrowImageView()
    }
    
    private func setupBackgroundImageView() {
        addSubview(backgroundImageView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 150),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setupArrowImageView() {
        addSubview(arrowImageView)
        
        NSLayoutConstraint.activate([
            arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 30),
            arrowImageView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

// MARK: - MotionManager

extension CompassView {
    private func configureMotionManager() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: .main) { [weak self] (data, error) in
                guard let self = self else { return }
                
                if let attitude = data?.attitude {
                    let rotation = atan2(attitude.pitch, attitude.roll)
                    UIView.animate(withDuration: 0.5) {
                        self.arrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
                    }
                }
            }
        }
    }
}
