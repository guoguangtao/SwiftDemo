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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        requestDataByNative { result in
            switch result {
            case let .success(dict):
                print(dict)
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
