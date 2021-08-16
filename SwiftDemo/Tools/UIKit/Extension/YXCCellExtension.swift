//
//  YXCCellExtension.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/16.
//

import UIKit

extension UICollectionViewCell {
    
    static func yxc_identifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
    
    static func yxc_registerCell(_ collectionView: UICollectionView) {
        collectionView.register(self.classForCoder(), forCellWithReuseIdentifier: self.yxc_identifier())
    }
    
    static func yxc_dequeueReusableCell(collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.yxc_identifier(), for: indexPath) as! Self
        return cell
    }
}

extension UITableViewCell {
    
    static func yxc_identifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
    
    static func yxc_registerCell(_ tableView: UITableView) {
        tableView.register(self.classForCoder(), forCellReuseIdentifier: self.yxc_identifier())
    }
    
    static func yxc_dequeueReusableCell(tableView: UITableView, indexPath: IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.yxc_identifier(), for: indexPath) as! Self
        return cell
    }
}
