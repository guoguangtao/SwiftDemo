//
//  UIViewEextension.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/10.
//

import UIKit
import Foundation

extension UIView {
    
    /// View 的 X 值
    var yxc_x: CGFloat {
        set {
            let oldFrame = self.frame
            self.frame = CGRect(x: newValue,
                                y: oldFrame.origin.y,
                                width: oldFrame.size.width,
                                height: oldFrame.size.height)
        }
        get {
            self.frame.origin.x
        }
    }
    
    /// View 的 Y 值
    var yxc_y: CGFloat {
        set {
            let oldFrame = self.frame
            self.frame = CGRect(x: oldFrame.origin.x,
                                y: newValue,
                                width: oldFrame.size.width,
                                height: oldFrame.size.height)
        }
        get {
            self.frame.origin.y
        }
    }
    
    /// View 的宽度
    var yxc_width: CGFloat {
        set {
            let oldFrame = self.frame
            self.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: newValue, height: oldFrame.size.height)
        }
        get {
            self.frame.size.height
        }
    }
    
    /// View 的高度
    var yxc_height: CGFloat {
        set {
            let oldFrame = self.frame
            self.frame = CGRect(x: oldFrame.origin.x, y: oldFrame.origin.y, width: oldFrame.size.width, height: newValue)
        }
        get {
            self.frame.size.height
        }
    }
    
    /// View 的 CenterX
    var yxc_centerX: CGFloat {
        set {
            let oldPoint = self.center
            self.center = CGPoint(x: newValue, y: oldPoint.y)
        }
        get {
            self.center.x
        }
    }
    
    /// View 的 CenterY
    var yxc_centerY: CGFloat {
        set {
            let oldPoint = self.center
            self.center = CGPoint(x: oldPoint.x, y: newValue)
        }
        get {
            self.center.y
        }
    }
    
    /// View 的 size
    var yxc_size: CGSize {
        set {
            self.frame.size = newValue
        }
        get {
            self.frame.size
        }
    }
    
    /// View 的 origin
    var yxc_origin: CGPoint {
        set {
            self.frame.origin = newValue
        }
        get {
            self.frame.origin
        }
    }
    
    /// View 的 左边的值（X的值）
    var yxc_left: CGFloat {
        set {
            self.yxc_x = newValue
        }
        get {
            self.yxc_x
        }
    }
    
    /// View 的顶部（Y 的值）
    var yxc_top: CGFloat {
        set {
            self.yxc_y = newValue
        }
        get {
            self.yxc_y
        }
    }
    
    /// View 的底部的值（在设置这个值之前，先设置 height）
    var yxc_bottom: CGFloat {
        set {
            self.yxc_y = newValue - self.yxc_height
        }
        get {
            self.yxc_y + self.yxc_height
        }
    }
    
    /// View 的右边的值 （在设置这个值之前，先设置 width）
    var yxc_right: CGFloat {
        set {
            self.yxc_x = newValue - self.yxc_width
        }
        get {
            self.yxc_x + self.yxc_width
        }
    }
    
    /// 移除所有子视图
    func yxc_removeAllSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}
