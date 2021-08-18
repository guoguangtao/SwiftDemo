//
//  UITextFieldController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/18.
//

import UIKit

class UITextFieldController: UIViewController {

    // MARK: - Property
    let textField = UITextField().then {
        $0.font = .systemFont(ofSize: 18, weight: .regular)
        $0.textColor = .systemOrange
        $0.borderStyle = .roundedRect
        $0.backgroundColor = .systemGray
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
    
    // MARK: - UI
    func setupUI() {
        
        self.view.addSubview(textField)
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
