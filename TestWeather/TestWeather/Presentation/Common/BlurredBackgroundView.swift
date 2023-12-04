//
//  BlurredBackgroundView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import UIKit

class BlurredBackgroundView: UIView {
    private let blurEffect = UIBlurEffect(style: .light)
    private var blurView: UIVisualEffectView {
        let view = UIVisualEffectView(effect: blurEffect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }
    
    init(contentView: UIView) {
        super.init(frame: .zero)
        setupBlurView(contentView: contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBlurView(contentView: UIView) {
        blurView.frame = contentView.bounds
        addSubview(blurView)
        sendSubviewToBack(blurView)
    }
}
