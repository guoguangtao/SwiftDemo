//
//  YXCTextView.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/19.
//

import UIKit

class YXCTextView: UITextView {
    
    /// 代理
    weak var yxc_delegate: YXCTextViewDelegate?
    
    deinit {
        yxc_debugPrintf("YXCTextView 被释放")
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - YXCTextView RuntimeKey

extension YXCTextView {
    
    /// YXCTextView runtime key
    private struct RuntimeKey {
        
        /// 文本长度限制
        static let yxc_textMaxLengthKey = UnsafeRawPointer.init(bitPattern: "yxc_textMaxLengthKey".hash)!
        
        /// 是否已经添加文本改变通知 Key
        static let yxc_didAddTextDidChangeNotificationKey = UnsafeRawPointer.init(bitPattern: "yxc_didAddTextDidChangeNotification".hash)!
        
        /// 是否已经添加开始编辑通知 Key
        static let yxc_didAddtextDidBeginEditingNotificationKey = UnsafeRawPointer.init(bitPattern: "yxc_didAddtextDidBeginEditingNotification".hash)!
        
        /// 是否已经添加结束编辑通知 Key
        static let yxc_didAddTextDidEndEditingNotificationKey = UnsafeRawPointer.init(bitPattern: "yxc_didAddTextDidEndEditingNotification".hash)!
        
        /// 是否禁用第三方键盘 Key
        static let yxc_usingSystemKeyboardKey = UnsafeRawPointer.init(bitPattern: "yxc_usingSystemKeyboard".hash)!
        
        /// 全局禁用第三方键盘 Flag Key
        static let yxc_globalUsingSystemKeyboardKey = UnsafeRawPointer.init(bitPattern: "yxc_globalUsingSystemKeyboard".hash)!
    }
}

// MARK: - YXCTextView 文本长度限制扩展

extension YXCTextView {
    
    /// 文本长度字数
    var yxc_textMaxLength: Int {
        set {
            objc_setAssociatedObject(self, YXCTextView.RuntimeKey.yxc_textMaxLengthKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if yxc_didAddTextDidChangeNotification == false {
                NotificationCenter.default.addObserver(self, selector: #selector(yxc_textView_textDidChangeNotification), name: YXCTextView.textDidChangeNotification, object: self)
                yxc_didAddTextDidChangeNotification = true
            }
        }
        get {
            if let length = objc_getAssociatedObject(self, YXCTextView.RuntimeKey.yxc_textMaxLengthKey) as? Int, length > 0 {
                return length
            }
            return NSNotFound
        }
    }
}

// MARK: - YXCTextView 第三方键盘禁用扩展

extension YXCTextView {
    
    /// 是否禁用第三方键盘
    var yxc_usingSystemKeyboard: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextView.RuntimeKey.yxc_usingSystemKeyboardKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if yxc_didAddtextDidBeginEditingNotification == false {
                NotificationCenter.default.addObserver(self, selector: #selector(yxc_textView_textDidBeginEditingNotification), name: YXCTextView.textDidBeginEditingNotification, object: self)
                yxc_didAddtextDidBeginEditingNotification = true
            }
            if yxc_didAddTextDidEndEditingNotification == false {
                NotificationCenter.default.addObserver(self, selector: #selector(yxc_textView_textDidEndEditingNotification), name: YXCTextView.textDidEndEditingNotification, object: self)
                yxc_didAddTextDidEndEditingNotification = true
            }
        }
        get {
            if let usingSystemKeyboard = objc_getAssociatedObject(self, YXCTextView.RuntimeKey.yxc_usingSystemKeyboardKey) as? Bool {
                return usingSystemKeyboard
            }
            return false
        }
    }
    
    /// 全局禁用第三方键盘 Flag
    private static var yxc_globalUsingSystemKeyboard: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextView.RuntimeKey.yxc_globalUsingSystemKeyboardKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let usingSystemKeyboard = objc_getAssociatedObject(self, YXCTextView.RuntimeKey.yxc_globalUsingSystemKeyboardKey) as? Bool {
                return usingSystemKeyboard
            }
            return false
        }
    }
    
    /// 设置是否禁用第三方键盘
    @objc static public func yxc_shouldAllowExtensionPointIdentifier(extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        if extensionPointIdentifier.rawValue == "com.apple.keyboard-service" {
            if yxc_globalUsingSystemKeyboard == true {
                return false
            }
        }
        
        return true
    }
}

// MARK: - YXCTextView 通知监听

extension YXCTextView {
    
    /// 是否已经添加文本改变通知
    private var yxc_didAddTextDidChangeNotification: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextView.RuntimeKey.yxc_didAddTextDidChangeNotificationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let didAdd = objc_getAssociatedObject(self, YXCTextView.RuntimeKey.yxc_didAddTextDidChangeNotificationKey) as? Bool {
                return didAdd
            }
            return false
        }
    }
    
    /// 监听开始编辑通知
    private var yxc_didAddtextDidBeginEditingNotification: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextView.RuntimeKey.yxc_didAddtextDidBeginEditingNotificationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let didAdd = objc_getAssociatedObject(self, YXCTextView.RuntimeKey.yxc_didAddtextDidBeginEditingNotificationKey) as? Bool {
                return didAdd
            }
            return false
        }
    }
    
    /// 监听结束编辑通知
    private var yxc_didAddTextDidEndEditingNotification: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextView.RuntimeKey.yxc_didAddTextDidEndEditingNotificationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let didAdd = objc_getAssociatedObject(self, YXCTextView.RuntimeKey.yxc_didAddTextDidEndEditingNotificationKey) as? Bool {
                return didAdd
            } else {
                return false
            }
        }
    }
    
    /// textView 文本发生改变通知
    @objc private func yxc_textView_textDidChangeNotification() {
        
        if yxc_textMaxLength == NSNotFound {
            return
        }
        
        if let selectedRange = markedTextRange, !selectedRange.isEmpty {
            return
        }
        
        let string = text
        if let count = string?.count, count > yxc_textMaxLength {
            text = string?.gyhs_subString(from: 0, to: yxc_textMaxLength - 1)
        }
        
        yxc_delegate?.yxc_textDidChanged(textView: self, text: text)
    }
    
    /// textView 文本开始编辑通知
    @objc private func yxc_textView_textDidBeginEditingNotification() {
        Self.yxc_globalUsingSystemKeyboard = self.yxc_usingSystemKeyboard
    }
    
    /// textView 文本结束编辑通知
    @objc private func yxc_textView_textDidEndEditingNotification() {
        Self.yxc_globalUsingSystemKeyboard = false
    }
}

// MARK: - YXCTextViewDelegate

/// YXCTextView 代理协议
protocol YXCTextViewDelegate: NSObject {
    
    /// 文本发生改变通知
    /// - Parameters:
    ///   - textView: textView
    ///   - text: 文本
    func yxc_textDidChanged(textView: YXCTextView, text: String);
}

extension YXCTextViewDelegate {
    
    /// 文本发生改变通知实现
    /// - Parameters:
    ///   - textView: textView
    ///   - text: 文本
    func yxc_textDidChanged(textView: YXCTextView, text: String) {
        
        yxc_debugPrintf("text: \(text), maxLengthCount: \(textView.yxc_textMaxLength)")
    }
}
