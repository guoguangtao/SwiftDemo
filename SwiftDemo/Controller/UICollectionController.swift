//
//  UICollectionController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/13.
//

import UIKit

class UICollectionController: UIViewController {

    // MARK: - Property
//    let collectionView = UICollectionView().then {
//    }
    
    // MARK: - Lazy
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        
    }
}
