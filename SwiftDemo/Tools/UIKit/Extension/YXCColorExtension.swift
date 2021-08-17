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
}
