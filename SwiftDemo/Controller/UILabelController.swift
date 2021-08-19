//
//  UILabelController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/13.
//

import UIKit
import Then

class UILabelController: UIViewController {

    
    // MARK: - Property
//    let label: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 15)
//        label.textColor = UIColor.systemOrange
//        label.numberOfLines = 0
//        label.textAlignment = NSTextAlignment.center
//        label.text = "这是一个 Label";
//
//        return label
//    }()
    
    
    /// 创建一个 Label，使用第三方 Then 的方式去创建
    let label = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = UIColor.systemOrange
        $0.numberOfLines = 0
        $0.textAlignment = NSTextAlignment.center
        $0.text = "这是一个 Label"
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
        label.snp.makeConstraints({
            $0.left.greaterThanOrEqualToSuperview().offset(20)
            $0.right.lessThanOrEqualToSuperview().offset(-20)
            $0.centerY.centerX.equalToSuperview()
        })
    }
}
