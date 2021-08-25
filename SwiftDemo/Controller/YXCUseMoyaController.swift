//
//  YXCUseMoyaController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/21.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit
import Moya

class UserInfo: NSObject, Codable {
    var name: String?
    var age: Int?
    
    override var debugDescription: String {
        "name:\(name ?? "nil"), age:\(age ?? 0)"
    }
    
    override var description: String {
        debugDescription
    }
}

class YXCUseMoyaController: UIViewController {

    // MARK: - Property
    
    let textView = YXCTextView().then {
        $0.font = .systemFont(ofSize: 14.0)
        $0.backgroundColor = .systemGray2
        $0.isEditable = false
    }
    
    let provider = MoyaProvider<HSECLiveShop>()
    
    
    // MARK: - 懒加载
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        setupUI()
        setupConstraints()
        requestData()
    }
    
    // MARK: - Custom Accessors (Setter 与 Getter 方法)
    
    
    // MARK: - IBActions
    
    @objc func injected() {
        
        self.view.yxc_removeAllSubViews()
        setupUI()
        setupConstraints()
        requestData()
    }
    
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    func requestData() {
        
        requestDataByMoyaRxSwift_02()
    }
    
    /// 使用 MoyaRxSwift
    func requestDataByMoyaRxSwift_02() {
        let _ = provider.rx.request(.thirdConfigs).mapJSON().subscribe { result in
            switch result {
            case let .success(response):
                guard let dictionary = response as? [String : Any] else {
                    print("非 字典")
                    return
                }
                print("请求成功！！！\(dictionary["retCode"]!)")
            case let .error(error):
                print(error)
            }
        }
    }
    
    /// 使用 MoyaRXSwift 方式
    func requestDataByMoyaRxSwift_01() {
       let _ = provider.rx.request(.thirdConfigs).subscribe { event in
            switch event {
            case let .success(response):
                // 将结果展示在 TextView
                guard let jsonString = try? response.mapString() else {
                    return
                }
                self.textView.text = jsonString
                
                guard let json = try? response.mapJSON() as? [String : Any?] else {
                    return
                }
                
                guard let retCode = json["retCode"] as? Int, retCode == 200 else {
                    print("网络请求失败")
                    return
                }
                
                print("网络请求成功:\(retCode)")
            case let .error(error):
                print(error)
            }
        }
    }
    
    /// 使用 Moya 请求
    func requestDataByMoya() {
        
        provider.request(.thirdConfigs) { (result) in
            switch result {
            case .success(let response):
                
                // 将结果展示在 TextView
                guard let jsonString = try? response.mapString() else {
                    return
                }
                self.textView.text = jsonString
                
                guard let json = try? response.mapJSON() as? [String : Any?] else {
                    return
                }
                
                guard let retCode = json["retCode"] as? Int, retCode == 200 else {
                    print("网络请求失败")
                    return
                }
                
                print("网络请求成功:\(retCode)")
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// 使用原生解析 Json
    func useNativeJson() {
        let jsonObject: [String : Any?] = [
            "respCode" : 200,
            "data" : [
                "name" : "Bob",
                "age" : 12
            ]
        ]
        
        guard let dataJson = jsonObject["data"] as? Dictionary<String, Any?> else {
            return
        }
        
        guard let data = try? JSONSerialization.data(withJSONObject: dataJson, options: .fragmentsAllowed) else {
            return
        }
        
        guard let userInfo = try? JSONDecoder().decode(UserInfo.self, from: data) else {
            return
        }
        
        print(userInfo)
    }
    
    
    // MARK: - Protocol
    
    
    // MARK: - UI
    
    func setupUI() -> Void {
        
        self.view.addSubview(textView)
        
        
    }
    
    
    // MARK: - Constraints
    
    func setupConstraints() -> Void {
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

public enum HSECLiveShop {
    // 获取第三方配置接口
    case thirdConfigs
}

extension HSECLiveShop: TargetType {
    public var baseURL: URL {
        URL(string: "https://dc.aadv.net:10443/")!
    }
    
    public var path: String {
        switch self {
        case .thirdConfigs:
            return "mobile/reconsitution/config/getThirdConfigs"
        }
    }
    
    public var method: Moya.Method {
        .get
    }
    
    public var sampleData: Data {
        switch self {
        case .thirdConfigs:
            return "请求 Data".data(using: String.Encoding.utf8)!
        }
    }
    
    public var task: Task {
        .requestParameters(parameters: ["name" : "Bob", "age" : "23"], encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        nil
    }
    
    
}
