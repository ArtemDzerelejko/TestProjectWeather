//
//  DividerView.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import UIKit

class DividerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DividerView {
    private func configure() {
        setupDivider()
    }
    
    private func setupDivider() {
        backgroundColor = .white
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
