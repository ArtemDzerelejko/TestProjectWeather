//
//  UIView+Extensions.swift
//  TestWeather
//
//  Created by artem on 08.11.2023.
//

import Foundation
import UIKit

protocol Withable {
    
    associatedtype T
    
    @discardableResult func with(_ closure: (_ instance: T) -> Void) -> T
}
extension Withable {
    
    @discardableResult func with(_ closure: (_ instance: Self) -> Void) -> Self {
        if let self = self as? UIView {
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        closure(self)
        return self
    }
}
extension NSObject: Withable { }
