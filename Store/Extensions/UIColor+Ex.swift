//
//  UIColor+Ex.swift
//  Store
//
//  Created by J Oh on 6/13/24.
//

import UIKit

extension UIColor {
    static let themeColor = UIColor(hex: "EF8947")
    static let blackColor = UIColor(hex: "000000")
    static let darkGrayColor = UIColor(hex: "4C4C4C")
    static let grayColor = UIColor(hex: "828282")
    static let lightGrayColor = UIColor(hex: "CDCDCD")
    static let whiteColor = UIColor(hex: "FFFFFF")
}

extension UIColor {
    
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}

