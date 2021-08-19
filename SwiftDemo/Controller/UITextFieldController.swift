//
//  UITextFieldController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/18.
//

import UIKit

class UITextFieldController: UIViewController, YXCTextFieldDelegate {
    

    // MARK: - Property
    let textField = YXCTextField().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .init(rgbHex: 0xFF0000)
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .systemGray
        $0.yxc_textMaxLength = 10
        $0.yxc_textMaxLength = 5
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
        print("---text: \(text ?? "")")
    }
    
    // MARK: - UI
    func setupUI() {
        
        self.view.addSubview(textField)
        textField.yxc_delegate = self
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        
        textField.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
    }
}
