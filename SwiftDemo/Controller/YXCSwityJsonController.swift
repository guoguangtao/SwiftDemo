//
//  YXCSwityJsonController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/26.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit
import Moya

class YXCSwityJsonController: UIViewController {

    typealias YXCCompletion = (_ result: Result<YXCThirdModel, Error>) -> Void
    
    let provider = MoyaProvider<HSECLiveShop>()
    var dataModel: YXCThirdModel?
    
    let tableView = UITableView().then {
        $0.tableFooterView = UIView()
        $0.rowHeight = 50
        UITableViewCell.yxc_registerCell($0)
    }
    
    deinit {
        print("YXCSwityJsonController 被释放")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        requestDataByNative { result in
            switch result {
            case let .success(dict):
                self.dataModel = dict
                self.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
    
    /// 使用原生解析 Json 数据
    func requestDataByNative(_ completion: @escaping YXCCompletion) {
        
        let _ = provider.rx.request(.thirdConfigs).mapJSON().subscribe { result in
            guard let dictionary = result as? [String : Any] else {
                completion(.failure(YXCResponseError.notDictionary))
                return
            }
            
            let retCode = dictionary["retCode"] ?? 0
            let message = dictionary["msg"] ?? "请求失败"
            
            guard retCode as? Int == 200 else {
                completion(.failure(YXCResponseError.retCodeNot200(retCode: retCode as! Int, desc: message as! String)))
                return
            }
            
            guard let dataDictionary = dictionary["data"] as? [String : Any] else {
                completion(.failure(YXCResponseError.noData))
                return
            }
            
            guard let data = try? JSONSerialization.data(withJSONObject: dataDictionary, options: .fragmentsAllowed) else {
                return
            }
            
            guard let dataModel = try? JSONDecoder().decode(YXCThirdModel.self, from: data) else {
                completion(.failure(YXCResponseError.noData))
                return
            }
            
            completion(.success(dataModel))
        } onError: { error in
            completion(.failure(error))
        }

    }
}

extension YXCSwityJsonController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return (dataModel?.HSXT_APP_COMMUNITY_ID?.count) ?? 0
        case 1:
            return (dataModel?.HSXT_APP_EC_ID?.count) ?? 0
        case 2:
            return (dataModel?.HSXT_APP_HOME_ID?.count) ?? 0
        case 3:
            return (dataModel?.HSXT_APP_MINE_ID?.count) ?? 0
        case 4:
            return (dataModel?.HSXT_APP_MSG_ID?.count) ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.yxc_dequeueReusableCell(forTableView: tableView, atIndexPath: indexPath)
        var string: String?
        switch indexPath.section {
        case 0:
            string = dataModel?.HSXT_APP_COMMUNITY_ID?[indexPath.row].categoryName
        case 1:
            string = dataModel?.HSXT_APP_EC_ID?[indexPath.row].categoryName
        case 2:
            string = dataModel?.HSXT_APP_HOME_ID?[indexPath.row].categoryName
        case 3:
            string = dataModel?.HSXT_APP_MINE_ID?[indexPath.row].categoryName
        case 4:
            string = dataModel?.HSXT_APP_MSG_ID?[indexPath.row].categoryName
        default:
            string = "nil"
        }
        cell.textLabel?.text = string
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

public enum YXCResponseError: Error {
    case notDictionary
    case retCodeNot200(retCode: Int, desc: String)
    case noData
}

struct YXCThirdModel: Codable {
    let HSXT_APP_COMMUNITY_ID: [YXCThirdItemModel]?
    let HSXT_APP_EC_ID: [YXCThirdItemModel]?
    let HSXT_APP_HOME_ID: [YXCThirdItemModel]?
    let HSXT_APP_MINE_ID: [YXCThirdItemModel]?
    let HSXT_APP_MSG_ID: [YXCThirdItemModel]?
}

struct YXCThirdItemModel: Codable {
    let categoryName: String?
}
