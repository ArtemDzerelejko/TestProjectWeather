//
//  CGFloat+Extensions.swift
//  TestWeather
//
//  Created by artem on 04.12.2023.
//

import Foundation

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * .pi / 180
    }
}
