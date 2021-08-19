//
//  YXCCollectionViewCell.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/15.
//

import UIKit

class YXCCollectionViewCell: UICollectionViewCell {
    
    private static var count: Int = 0
    
    private let textLabel = UILabel().then {
        $0.textColor = UIColor.systemOrange
        $0.font = UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.heavy)
    }
    
    private var index = -1
    
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
        Self.count += 1
        index = Self.count
        print("创建第\(Self.count)个 Cell")
        contentView.backgroundColor = .yxc_randomColor
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("\(index) 被释放")
        Self.count -= 1
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
