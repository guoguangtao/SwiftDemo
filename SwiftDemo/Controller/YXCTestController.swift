//
//  YXCTestController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/16.
//

import UIKit

class YXCTestController: UIViewController {

    // MARK: - Property
    
    let redView = UIView().then {
        $0.backgroundColor = .systemRed
    }
    
    let blueView = UIView().then {
        $0.backgroundColor = .systemBlue
    }
    
    
    // MARK: - 懒加载
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - Custom Accessors (Setter 与 Getter 方法)
    
    
    // MARK: - IBActions
    
    @objc func injected() {
        
        self.view.yxc_removeAllSubViews()
        
        setupUI()
        setupConstraints()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let result = touch.view?.isDescendant(of: redView)
            if result == true {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    
    // MARK: - Protocol
    
    
    // MARK: - UI
    
    func setupUI() {
        
        view.addSubview(redView)
        view.addSubview(blueView)
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() {
        
        redView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.snp_bottomMargin)
            $0.top.equalTo(view.snp_topMargin)
        }
        
        blueView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview().offset(-120)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    

}
