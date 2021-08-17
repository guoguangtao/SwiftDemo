//
//  YXCCollectionViewCell.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/15.
//

import UIKit

class YXCCollectionViewCell: UICollectionViewCell {
    
    private let textLabel = UILabel().then {
        $0.textColor = UIColor.systemOrange
        $0.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
    }
    
    private var index = -1
    
    public var indexPath: NSInteger {
        set {
            if index < 0 {
                index = newValue
            }
        }
        get {
            index
        }
    }
    
    public var textString: String? {
        set {
            textLabel.text = newValue ?? ""
        }
        get {
            textLabel.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .yxc_randomColor
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("\(self.index) 被释放")
    }
    
    func setupUI() {
        
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(textLabel)
    }
    
    func setupConstraints() {
        textLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc func injected() {
        
        setupUI()
        setupConstraints()
    }
}
