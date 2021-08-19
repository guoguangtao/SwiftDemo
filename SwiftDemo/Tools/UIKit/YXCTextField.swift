//
//  YXCTextFieldExtension.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/19.
//

import UIKit

protocol YXCTextFieldDelegate: NSObject {
    
    func yxc_textDidChanged(textField: YXCTextField, text: String?);
}

extension YXCTextFieldDelegate {
    
    func yxc_textDidChanged(textField: YXCTextField, text: String?) {
        
        print("text: \(text ?? ""), textMaxLength: \(textField.yxc_textMaxLength)")
    }
}

class YXCTextField: UITextField {
    
    deinit {
        print("TextField 被释放")
    }
}

extension YXCTextField {
    
    public convenience init(frame: CGRect, textMaxLength: Int) {
        self.init(frame: frame)
        yxc_textMaxLength = textMaxLength
    }
    
    private struct YXCNotificationFlag {
        var didAddTextDidChangeNotification: Int8
    }
    
    /// 关于运行时的一些 key 的定义
    private struct RuntimeKey {
        
        /// UITextField 可输入最大长度 Key
        static let yxc_textMaxLengthKey = UnsafeRawPointer.init(bitPattern: "yxc_textMaxLength".hash)!
        
        /// 是否已经添加通知监听文本改变
        static let yxc_didAddTextDidChangeNotificationKey = UnsafeRawPointer.init(bitPattern: "yxc_didAddTextDidChangeNotification".hash)!
        
        /// 设置 yxc_delegate key
        static let yxc_delegateKey = UnsafeRawPointer.init(bitPattern: "yxc_delegate".hash)!
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
                NotificationCenter.default.addObserver(self, selector: #selector(yxc_textField_textDidChangeNotification), name: UITextField.textDidChangeNotification, object: self)
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
    
    @objc func yxc_textField_textDidChangeNotification () {
        
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
