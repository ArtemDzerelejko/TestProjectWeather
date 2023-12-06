//
//  BlurredBackgroundView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import UIKit

class BlurredBackgroundViewHelper {
    
    static func setupBlurredBackground(for view: UIView, height: CGFloat = 160) {
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(blurView)
        view.backgroundColor = .clear
        blurView.alpha = 0.8
        blurView.clipsToBounds = true
        blurView.layer.cornerRadius = 15

        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            view.heightAnchor.constraint(equalToConstant: height),
        ])
    }
    
    static func createBlurView(with style: UIBlurEffect.Style, for tableView: UITableView) -> UIVisualEffectView {
            let blurEffect = UIBlurEffect(style: style)
            let blurView = UIVisualEffectView(effect: blurEffect)
            blurView.frame = tableView.bounds
            blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            return blurView
        }
}
