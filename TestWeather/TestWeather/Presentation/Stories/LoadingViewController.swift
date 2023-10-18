//
//  LoadingViewController.swift
//  TestWeather
//
//  Created by artem on 12.10.2023.
//

import Foundation
import UIKit

final class LoadingViewController: UIViewController {
    
    private let iconView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        transition()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}

// MARK: - UI

extension LoadingViewController {
    private func configureUI() {
        setupBackground()
        setupIconView()
    }
    
    private func setupBackground() {
        let gradientView = GradientBackgroundView(frame: view.bounds)
        gradientView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(gradientView)
    }
    
    private func setupIconView() {
        iconView.image = UIImage(systemName: Strings.cloudSunRainFill)
        iconView.tintColor = .white
        view.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            iconView.widthAnchor.constraint(equalToConstant: 200),
            iconView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

// MARK: - creating transition

extension LoadingViewController {
    private func transition() {
        creatingTransition()
    }
    
    private func creatingTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.transitionToMainViewController()
        }
    }
}

// MARK: - create next VC

extension LoadingViewController {
    private func transitionToMainViewController() {
        let mainViewController = MainViewController()
        navigationController?.pushViewController(mainViewController, animated: true)
    }
}
