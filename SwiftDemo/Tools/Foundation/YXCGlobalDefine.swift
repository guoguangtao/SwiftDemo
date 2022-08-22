//
//  YXCGlobalDefine.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/19.
//

import Foundation
import UIKit

/// debug环境打印
/// - Parameter message: 打印消息
func yxc_debugPrintf(_ message: Any...) {
    debugPrint(message)
}

/// 屏幕宽度
let screenWidth = UIScreen.main.bounds.width

/// 屏幕高度
let screenHeight = UIScreen.main.bounds.height

/// x 的比例
let scaleX = screenWidth / 375.0

/// y 的比例
let scaleY = screenHeight / 667.0

/// 状态栏高度
var statusBarHeight: (CGFloat) {
    var height: CGFloat = 0
    if #available(iOS 13.0, *) {
        let statusBarManager = UIApplication.shared.windows.first?.windowScene?.statusBarManager
        height = statusBarManager?.statusBarFrame.height ?? 0.0
    } else {
        height = UIApplication.shared.statusBarFrame.height
    }

    return height
}

var yxc_window: UIWindow? {
    get {
        if let window = UIApplication.shared.windows.first {
            return window
        }
        return nil
    }
}

/// 刘海屏底部高度
var safeBottomHeight: (CGFloat) {
    get {
        return yxc_window?.safeAreaInsets.bottom ?? 0
    }
}

/// 是否是刘海屏幕
var isBangScreen: (Bool) {
    get {
        return yxc_window?.safeAreaInsets.top ?? 0 > 0 ||
        yxc_window?.safeAreaInsets.left ?? 0 > 0 ||
        yxc_window?.safeAreaInsets.bottom ?? 0 > 0 ||
        yxc_window?.safeAreaInsets.right ?? 0 > 0
    }
}

/// 导航栏高度
let navigationHeight = statusBarHeight + 44;
