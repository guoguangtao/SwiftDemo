//
//  UITextFieldController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/18.
//

import UIKit

class UITextFieldController: UIViewController, YXCTextFieldDelegate {
    

    // MARK: - Property
    let textField01 = YXCTextField().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .init(rgbHex: 0xFFFFFF)
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .systemGray
        $0.yxc_textMaxLength = 10
        $0.yxc_usingSystemKeyboard = false
    }
    
    let textField02 = YXCTextField().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .init(rgbHex: 0xFFFFFF)
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .systemGray
        $0.yxc_textMaxLength = 10
        $0.yxc_usingSystemKeyboard = true
    }
    
    // MARK: - Lazy
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupUI()
        setupConstraints()
    }
    
    // MARK: - IBActions
    
    @objc func injected() {
        
        self.view.yxc_removeAllSubViews()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    
    // MARK: - Procotol
    
    // MARK: YXCTextFieldDelegate
     
    func yxc_textDidChanged(textField: YXCTextField, text: String?) {
        yxc_debugPrintf("---text: \(text ?? "")")
    }
    
    // MARK: - UI
    func setupUI() {
        
        self.view.addSubview(textField01)
        textField01.yxc_delegate = self
        
        self.view.addSubview(textField02)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        
        textField01.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        textField02.snp.makeConstraints {
            $0.bottom.equalTo(textField01.snp_topMargin).offset(-20)
            $0.left.right.height.equalTo(textField01)
        }
    }
}
