//
//  YXCJsonParsingController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/24.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit

// https://juejin.cn/post/6971997599725256734
/// 使用原生解析 Json 数据，并且模型化
class YXCJsonParsingController: UIViewController {
    
    let label = UILabel().then {
        $0.numberOfLines = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let json = #"""
            {
                "id" : "1",
                "name" : "Bob",
                "age" : 20
            }
            """#
        
        let person = try? JSONDecoder().decode(YXCPerson.self, from: json.data(using: .utf8)!)
        
        self.view.addSubview(label)
        label.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
        label.text = person?.description
        
        print(person ?? "Person = nil")
    }
}

struct YXCPerson: Codable, CustomDebugStringConvertible, CustomStringConvertible {
    
    let studentId: String?
    
    /// 名称
    let name: String?
    
    /// 年龄
    let age: String?
    
    /// 跟后台返回的键值不一致配置
    enum CodingKeys: String, CodingKey {
        case studentId = "id"
        case name
        case age
    }
    
    var debugDescription: String {
        "Person"
    }
    
    var description: String {
        debugDescription
    }
}
