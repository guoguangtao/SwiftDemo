//
//  YXCJsonParsingController.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/24.
//  Copyright © 2021 GGT. All rights reserved.
//

import UIKit


/// 使用原生解析 Json 数据，并且模型化
class YXCJsonParsingController: UIViewController {
    
    let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        let json = #"""
            {
                "name" : "Bob",
                "age" : 20
            }
            """#
        
        let person = try? JSONDecoder().decode(YXCPerson.self, from: json.data(using: .utf8)!)
        
        self.view.addSubview(label)
        label.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        label.text = person?.description
    }
}

struct YXCPerson: Codable, CustomDebugStringConvertible, CustomStringConvertible {
    
    /// 名称
    let name: String?
    
    /// 年龄
    let age: Int?
    
    var debugDescription: String {
        "Person.name : \(name ?? "nil"), Person.age : \(age ?? 0)"
    }
    
    var description: String {
        debugDescription
    }
}
