//
//  UIImage+Extensions.swift
//  TestWeather
//
//  Created by artem on 18.12.2023.
//

import UIKit

extension UIImage {
    func scaledToFitSize(_ size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal)
    }
    
    func roundedImage(withCornerRadius cornerRadius: CGFloat) -> UIImage {
           UIGraphicsImageRenderer(size: size).image { context in
               let rect = CGRect(origin: .zero, size: size)
               UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
               draw(in: rect)
           }
       }
}
