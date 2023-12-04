//
//  CompassView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import UIKit
import CoreMotion

class CompassArrowView: UIView {

    private var motionManager = CMMotionManager()
    private let backgroundImageView = UIImageView()
    private let arrowImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureMotionManager()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureUI() {
        // Додавання фонового зображення
        backgroundImageView.image = UIImage(resource: .comp) // Замініть "yourBackgroundImage" на назву вашого малюнка
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgroundImageView)

        // Додавання стрілки
        arrowImageView.image = UIImage(systemName: "location.north")
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.tintColor = .white
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(arrowImageView)

        // Розміщення елементів з constraints
        NSLayoutConstraint.activate([
            backgroundImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            backgroundImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            backgroundImageView.widthAnchor.constraint(equalToConstant: 150),
            backgroundImageView.heightAnchor.constraint(equalToConstant: 150),

            arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            arrowImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 30),
            arrowImageView.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

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
