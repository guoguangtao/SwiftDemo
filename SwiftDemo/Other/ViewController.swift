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
        setupNavigation()
    }
    
    
    // MARK: - Custom Accessors (Setter 与 Getter 方法)
    
    
    // MARK: - IBActions
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    @objc func injected() {
        
        setupUI()
        setupNavigation()
    }
    
    
    // MARK: - Protocol
    
    
    // MARK: - UI
    
    func setupUI() -> Void {
        
    }
    
    func setupNavigation() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() {
        
    }
    
    // MARK: - Property
    
    
    // MARK: - 懒加载
    
    
    // MARK: - Class
    
}

