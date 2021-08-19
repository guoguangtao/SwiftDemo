//
//  YXCColorExtension.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/17.
//

import UIKit

extension UIColor {
    
    /// 随机色
    open class var yxc_randomColor: UIColor {
        get {
            UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
        }
    }
    
    @objc public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
    
    @objc public convenience init(rgbHex hex: UInt32) {
        let r = CGFloat((hex >> 16) & 0xFF)
        let g = CGFloat((hex >> 8) & 0xFF)
        let b = CGFloat ((hex) & 0xFF)
        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
