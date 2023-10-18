//
//  CustomBarButtonItem.swift
//  TestWeather
//
//  Created by artem on 17.10.2023.
//

import Foundation
import UIKit

class CustomBackButton: UIButton {
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        
        let backButtonImage = UIImage(systemName: Strings.arrowBackwardCircle)
        setBackgroundImage(backButtonImage, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
