//
//  ViewController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/9.
//

import UIKit


class ViewController: UIViewController {

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    
    // MARK: - Custom Accessors (Setter 与 Getter 方法)
    
    
    // MARK: - IBActions
    
    @objc func buttonClicked(button: UIButton) {
    
        button.setTitle("123", for: UIControl.State.normal)
        button.backgroundColor = UIColor.systemRed
    }
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    @objc func injected() {
        
        setupUI()
        setupNavigation()
    }
    
    
    // MARK: - Protocol
    
    
    // MARK: - UI
    
    func setupUI() -> Void {
        
        let button = UIButton()
        button.yxc_width = 200
        button.yxc_height = 50
        button.center = self.view.center
        button.backgroundColor = UIColor.systemOrange
        button.addTarget(self, action: #selector(buttonClicked(button:)), for: UIControl.Event.touchUpInside)
        self.view.addSubview(button)
    }
    
    func setupNavigation() {
        self.title = "测试界面"
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() -> Void {
        
    }
    
    // MARK: - Property
    
    
    // MARK: - 懒加载
    
    
    
    // MARK: - Class
    
}

extension UIView {
    public var yxc_width: CGFloat {
        set {
            let frame = self.frame
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: newValue, height:frame.size.height)
        }
        get {
            return self.frame.size.height
        }
    }
    
    public var yxc_height: CGFloat {
        set {
            let frame = self.frame
            self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.size.width, height:newValue)
        }
        get {
            return self.frame.size.height
        }
    }
}

