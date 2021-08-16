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
    
    public var indexPath: NSInteger = -1
    
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
        contentView.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)) / 255.0, green: CGFloat(arc4random_uniform(255)) / 255.0, blue: CGFloat(arc4random_uniform(255)) / 255.0, alpha: 1.0)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    deinit {
        print("\(self.indexPath) 被释放")
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
