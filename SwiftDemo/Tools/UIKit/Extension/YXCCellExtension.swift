//
//  YXCCellExtension.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/16.
//

import UIKit

extension UICollectionViewCell {
    
    /// 获取 Cell Identifier
    static func yxc_identifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
    
    /// 给某个 CollectionView 注册当前 cell
    /// - Parameter collectionView: collectionView
    static func yxc_registerCell(_ collectionView: UICollectionView) {
        collectionView.register(self.classForCoder(), forCellWithReuseIdentifier: self.yxc_identifier())
    }
    
    /// 根据某个 CollectionView 从复用池中获取一个 Cell
    /// - Parameters:
    ///   - collectionView: collectionView
    ///   - indexPath: indexPath
    /// - Returns: cell
    static func yxc_dequeueReusableCell(forCollectionView collectionView: UICollectionView, atIndexPath indexPath: IndexPath) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.yxc_identifier(), for: indexPath) as! Self
        return cell
    }
}

extension UITableViewCell {
    
    /// 获取 Cell Identifier
    static func yxc_identifier() -> String {
        return NSStringFromClass(self.classForCoder())
    }
    
    /// 给某个 tableView 注册当前 cell
    /// - Parameter tableView: tableView
    static func yxc_registerCell(_ tableView: UITableView) {
        tableView.register(self.classForCoder(), forCellReuseIdentifier: self.yxc_identifier())
    }
    
    /// 根据某个 TableView 从复用池中获取一个 Cell
    /// - Parameters:
    ///   - tableView: tableView
    ///   - indexPath: indexPath
    /// - Returns: cell
    static func yxc_dequeueReusableCell(forTableView tableView: UITableView, atIndexPath indexPath: IndexPath) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.yxc_identifier(), for: indexPath) as! Self
        return cell
    }
}
