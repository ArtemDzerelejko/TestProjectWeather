//
//  CustomImageView.swift
//  TestWeather
//
//  Created by artem on 19.10.2023.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    var customSize: CGSize = CGSize(width: 20, height: 20)
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.contentMode = .scaleAspectFit
        self.clipsToBounds = true
        self.image = self.image?.withRenderingMode(.alwaysTemplate)
        self.frame.size = customSize
    }
}
