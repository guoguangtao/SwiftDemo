//
//  YXCUseMoyaController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/21.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit
import Moya

class YXCUseMoyaController: UIViewController {

    // MARK: - Property
    
    let textView = YXCTextView().then {
        $0.font = .systemFont(ofSize: 14.0)
        $0.backgroundColor = .systemGray2
        $0.isEditable = false
    }
    
    
    // MARK: - 懒加载
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        setupConstraints()
        requestData()
    }
    
    // MARK: - Custom Accessors (Setter 与 Getter 方法)
    
    
    // MARK: - IBActions
    
    @objc func injected() {
        
        self.view.yxc_removeAllSubViews()
        setupUI()
        setupConstraints()
        requestData()
    }
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    func requestData() {
        
    }
    
    
    // MARK: - Protocol
    
    
    // MARK: - UI
    
    func setupUI() -> Void {
        
        self.view.addSubview(textView)
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() -> Void {
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
