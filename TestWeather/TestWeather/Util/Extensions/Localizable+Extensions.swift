//
//  Localizable+Extensions.swift
//  TestWeather
//
//  Created by artem on 17.10.2023.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
