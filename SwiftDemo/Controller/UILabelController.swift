//
//  UILabelController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/13.
//

import UIKit

class UILabelController: UIViewController {

    
    // MARK: - Property
    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.systemOrange
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.text = "这是一个 Label";
        
        return label
    }()
    
    
    // MARK: - 懒加载
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    
    // MARK: - Protocol
    
    
    // MARK: - UI
    
    func setupUI() -> Void {
        
        self.view.addSubview(label)
        
        let attributedString = NSMutableAttributedString(string: "属性字符串", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor.systemOrange,
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        ])
        label.attributedText = attributedString
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() -> Void {
        label.snp.makeConstraints { make in
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.centerY.equalTo(self.view)
        }
    }
}
