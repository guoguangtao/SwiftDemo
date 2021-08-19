//
//  UIButtonController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/11.
//

import UIKit

class UIButtonController: UIViewController {
    
    // MARK: - Property
    
    /// 第一个按钮
    var button_01: UIButton!
    
    /// 第二个按钮
    var button_02: UIButton!
    
    // MARK: - 懒加载
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "UIButton 的使用"
        
        self.view.backgroundColor = UIColor.white
        
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
    
    @objc func buttonClicked(button: UIButton) {
        
        yxc_debugPrintf(button.currentTitle ?? "标题未获取到")
    }
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    private func p_createdButton(title: String, backgroundColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: UIControl.State.normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 20.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(buttonClicked), for: UIControl.Event.touchUpInside)
        
        return button
    }
    
    
    // MARK: - Protocol
    
    
    // MARK: - UI
    
    func setupUI() {
        
        button_01 = p_createdButton(title: "第一个按钮", backgroundColor: UIColor.systemOrange)
        self.view.addSubview(button_01)
        button_02 = p_createdButton(title: "第二个按钮", backgroundColor: UIColor.systemRed)
        self.view.addSubview(button_02)
    }
    
    
    // MARK: - Constraints

    func setupConstraints() {
    
        button_01.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.centerY.equalTo(self.view)
            make.height.equalTo(40)
        }
        
        button_02.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(button_01)
            make.top.equalTo(button_01.snp_bottomMargin).offset(20)
        }
    }
}
