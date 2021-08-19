//
//  UITextViewController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/19.
//

import UIKit

class UITextViewController: UIViewController, YXCTextViewDelegate {

    // MARK: - Property
    let textView_01 = YXCTextView().then {
        $0.font = .systemFont(ofSize: 14.0)
        $0.backgroundColor = .systemGray2
        $0.yxc_textMaxLength = 5
        $0.yxc_usingSystemKeyboard = true
    }
    
    let textView_02 = YXCTextView().then {
        $0.font = .systemFont(ofSize: 14.0)
        $0.backgroundColor = .systemGray2
    }
    
    // MARK: - 懒加载
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Custom Accessors (Setter 与 Getter 方法)
    
    
    // MARK: - IBActions
    
    @objc func injected() {
        
        self.view.yxc_removeAllSubViews()
        setupUI()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    
    // MARK: - Protocol
    
    // MARK: - YXCTextViewDelegate
    
    func yxc_textDidChanged(textView: YXCTextView, text: String) {
        yxc_debugPrintf("---\(text)")
    }
    
    
    // MARK: - UI
    
    func setupUI() -> Void {
        
        self.view.addSubview(textView_01)
        textView_01.yxc_delegate = self
        self.view.addSubview(textView_02)
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() -> Void {
        
        textView_01.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(100)
            $0.top.equalTo(self.view.snp_topMargin).offset(20)
        }
        
        textView_02.snp.makeConstraints {
            $0.left.right.height.equalTo(textView_01)
            $0.top.equalTo(textView_01.snp_bottomMargin).offset(20)
        }
    }
}
