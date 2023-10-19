//
//  CustomLabel.swift
//  TestWeather
//
//  Created by artem on 18.10.2023.
//

import Foundation
import UIKit

final class CustomLabel: UILabel {
    init(textColor: UIColor = .white, fontSize: CGFloat = 20) {
        super.init(frame: .zero)
        commonInit(textColor: textColor, fontSize: fontSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)}
    
    private func commonInit(textColor: UIColor, fontSize: CGFloat = 20) {
        self.font = UIFont.boldSystemFont(ofSize: fontSize)
        self.textColor = textColor
    }
}
