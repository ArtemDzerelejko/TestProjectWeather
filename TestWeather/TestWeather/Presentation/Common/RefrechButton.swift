//
//  RefrechButton.swift
//  TestWeather
//
//  Created by artem on 18.10.2023.
//

import Foundation
import UIKit

class RefrechButton: UIButton {
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let clockArrowImage = UIImage(systemName: Strings.clockArrow)
        setBackgroundImage(clockArrowImage, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
