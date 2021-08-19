//
//  YXCTextFieldExtension.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/19.
//

import UIKit

protocol YXCTextFieldDelegate: NSObject {
    
    /// 文本发生改变
    /// - Parameters:
    ///   - textField: 输入框
    ///   - text: 当前输入框文本
    func yxc_textDidChanged(textField: YXCTextField, text: String?);
}

extension YXCTextFieldDelegate {
    
    func yxc_textDidChanged(textField: YXCTextField, text: String?) {
        
        yxc_debugPrintf("text: \(text ?? ""), textMaxLength: \(textField.yxc_textMaxLength)")
    }
}

class YXCTextField: UITextField {
    
    deinit {
        yxc_debugPrintf("TextField 被释放")
        NotificationCenter.default.removeObserver(self)
    }
}

extension YXCTextField {
    
    /// 关于运行时的一些 key 的定义
    private struct RuntimeKey {
        
        /// UITextField 可输入最大长度 Key
        static let yxc_textMaxLengthKey = UnsafeRawPointer.init(bitPattern: "yxc_textMaxLength".hash)!
        
        /// 是否已经添加通知监听文本改变
        static let yxc_didAddTextDidChangeNotificationKey = UnsafeRawPointer.init(bitPattern: "yxc_didAddTextDidChangeNotification".hash)!
        
        /// 设置 yxc_delegate key
        static let yxc_delegateKey = UnsafeRawPointer.init(bitPattern: "yxc_delegate".hash)!
        
        /// 设置 当前 TextField 是否使用系统键盘 key
        static let yxc_usingSystemKeyboardKey = UnsafeRawPointer.init(bitPattern: "yxc_usingSystemKeyboard".hash)!
        
        /// 全局是否禁用第三方键盘 key
        static let yxc_globalUsingSystemKeyboardKey = UnsafeRawPointer.init(bitPattern: "yxc_globalUsingSystemKeyboard".hash)!
        
        /// 是否已经添加开始编辑通知监听 key
        static let yxc_didAddtextDidBeginEditingNotificationKey = UnsafeRawPointer.init(bitPattern: "yxc_didAddtextDidBeginEditingNotification".hash)!
        
        /// 是否已经添加结束编辑通知监听 key
        static let yxc_didAddTextDidEndEditingNotificationKey = UnsafeRawPointer.init(bitPattern: "yxc_didAddTextDidEndEditingNotification".hash)!
    }
}

// MARK: - YXCTextField 文本长度限制扩展

extension YXCTextField {
    
    public convenience init(frame: CGRect, textMaxLength: Int) {
        self.init(frame: frame)
        yxc_textMaxLength = textMaxLength
    }
    
    /// 是否已经添加文本改变通知
    private var yxc_didAddTextDidChangeNotification: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextField.RuntimeKey.yxc_didAddTextDidChangeNotificationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let didAdd = objc_getAssociatedObject(self, YXCTextField.RuntimeKey.yxc_didAddTextDidChangeNotificationKey) as? Bool {
                return didAdd
            } else {
                return false
            }
        }
    }
    
    /// UITextField 可输入最大长度
    var yxc_textMaxLength: Int {
        set {
            objc_setAssociatedObject(self, YXCTextField.RuntimeKey.yxc_textMaxLengthKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if yxc_didAddTextDidChangeNotification == false {
                NotificationCenter.default.addObserver(self, selector: #selector(yxc_textField_textDidChangeNotification), name: YXCTextField.textDidChangeNotification, object: self)
                yxc_didAddTextDidChangeNotification = true
            }
        }
        get {
            let maxLength = objc_getAssociatedObject(self, YXCTextField.RuntimeKey.yxc_textMaxLengthKey) as! Int
            if maxLength > 0 {
                return maxLength
            }
            return NSNotFound
        }
    }
    
    /// 代理
    weak var yxc_delegate: YXCTextFieldDelegate? {
        set {
            if newValue != nil {
                objc_setAssociatedObject(self, YXCTextField.RuntimeKey.yxc_delegateKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_ASSIGN)
            }
        }
        get {
            if let yxc_dele = objc_getAssociatedObject(self, YXCTextField.RuntimeKey.yxc_delegateKey) as? YXCTextFieldDelegate {
                return yxc_dele
            }
            return nil
        }
    }
}

// MARK: - YXCTextField 第三方键盘禁用扩展

extension YXCTextField {
    
    /// 监听开始编辑通知
    private var yxc_didAddtextDidBeginEditingNotification: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextField.RuntimeKey.yxc_didAddtextDidBeginEditingNotificationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let didAdd = objc_getAssociatedObject(self, YXCTextField.RuntimeKey.yxc_didAddtextDidBeginEditingNotificationKey) as? Bool {
                return didAdd
            } else {
                return false
            }
        }
    }
    
    /// 监听结束编辑通知
    private var yxc_didAddTextDidEndEditingNotification: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextField.RuntimeKey.yxc_didAddTextDidEndEditingNotificationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let didAdd = objc_getAssociatedObject(self, YXCTextField.RuntimeKey.yxc_didAddTextDidEndEditingNotificationKey) as? Bool {
                return didAdd
            } else {
                return false
            }
        }
    }
    
    /// 是否使用系统键盘，禁用第三方键盘
    var yxc_usingSystemKeyboard: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextField.RuntimeKey.yxc_usingSystemKeyboardKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if yxc_didAddtextDidBeginEditingNotification == false {
                NotificationCenter.default.addObserver(self, selector: #selector(yxc_textField_textDidBeginEditingNotification), name: YXCTextField.textDidBeginEditingNotification, object: self)
                yxc_didAddtextDidBeginEditingNotification = true
            }
            if yxc_didAddTextDidEndEditingNotification == false {
                NotificationCenter.default.addObserver(self, selector: #selector(yxc_textField_textDidEndEditingNotification), name: YXCTextField.textDidEndEditingNotification, object: self)
                yxc_didAddTextDidEndEditingNotification = true
            }
        }
        get {
            if let usingSystemKeyboard = objc_getAssociatedObject(self, YXCTextField.RuntimeKey.yxc_usingSystemKeyboardKey) as? Bool {
                return usingSystemKeyboard
            }
            return false
        }
    }
    
    /// 类属性 全局设置禁用第三方键盘标志
    private static var yxc_globalUsingSystemKeyboard: Bool {
        set {
            objc_setAssociatedObject(self, YXCTextField.RuntimeKey.yxc_globalUsingSystemKeyboardKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let usingSystemKeyboard = objc_getAssociatedObject(self, YXCTextField.RuntimeKey.yxc_globalUsingSystemKeyboardKey) as? Bool {
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

// MARK: - YXCTextField 通知监听

extension YXCTextField {
    
    /// 开始编辑通知监听
    @objc private func yxc_textField_textDidBeginEditingNotification() {
        Self.yxc_globalUsingSystemKeyboard = self.yxc_usingSystemKeyboard
    }
    
    /// 结束编辑通知监听
    @objc private func yxc_textField_textDidEndEditingNotification() {
        Self.yxc_globalUsingSystemKeyboard = false
    }
    
    /// 文本发生改变通知监听
    @objc private func yxc_textField_textDidChangeNotification () {
        
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
        
        yxc_delegate?.yxc_textDidChanged(textField: self, text: text)
    }
}
