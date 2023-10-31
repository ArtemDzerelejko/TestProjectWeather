//
//  SmallView.swift
//  TestWeather
//
//  Created by artem on 31.10.2023.
//

import Foundation
import UIKit

class SmallView: UIView {
    
    private let titleView = UIView()
    private let titleImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SmallView {
    private func configureUI() {
        setupMainView()
        setupTitleView()
    }
    
    private func setupMainView() {
        backgroundColor = .lightBlue
        layer.cornerRadius = 15
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
            heightAnchor.constraint(equalToConstant: 160),
            widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupTitleView() {
        titleView.backgroundColor = .red
        addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleView.heightAnchor.constraint(equalToConstant: 20),
            titleView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
