//
//  UICollectionController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/13.
//

import UIKit

class UICollectionController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    // MARK: - Property
    let collectionView: UICollectionView = {
        let CGRectZero = CGRect(x: 0, y: 0, width: 0, height: 0)
        let layout = UICollectionViewFlowLayout()
        let minimumLineSpacing: CGFloat = 10.0
        let minimumInteritemSpacing: CGFloat = 5.0
        let count: CGFloat = 4.0
        let sectionInset: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        var width = UIScreen.main.bounds.size.width - (count - 1.0) * minimumInteritemSpacing - sectionInset.left - sectionInset.right
        let itemWH: CGFloat = CGFloat(floor(Double(width / count)))
        layout.itemSize = CGSize(width: itemWH, height: itemWH)
        layout.sectionInset = sectionInset
        layout.minimumLineSpacing = minimumLineSpacing
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        let  collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        YXCCollectionViewCell.yxc_registerCell(collectionView)
        collectionView.backgroundColor = UIColor.systemBackground
        
        return collectionView
    }()
    
    // MARK: - Lazy
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemBackground
        
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
    // MARK: UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YXCCollectionViewCell = YXCCollectionViewCell.yxc_dequeueReusableCell(collectionView: collectionView, indexPath: indexPath)
        cell.textString = "\(indexPath.row)"
        cell.indexPath = indexPath.row + 1
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("第 \(indexPath.row) 被点击")
    }
    
    // MARK: - UI
    func setupUI() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
