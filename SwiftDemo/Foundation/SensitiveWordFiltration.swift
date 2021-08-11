//
//  SensitiveWordFiltration.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/10.
//

import Foundation

/// 处理结果返回
typealias FilterResult = (isContain: Bool, filteredText: String)

///  敏感词模型
///
/// - 属性 : childrens - 字典树
/// - 属性 : word - 敏感词
class SensitiveWordModel {
    
    /// 定义一个字典代表树
    var childrens: [String : SensitiveWordModel] = NSMutableDictionary() as! [String : SensitiveWordModel]
    
    /// 是否是敏感词的最后一个字
    var word: String = ""
}

/// 敏感词过滤
class SensitiveWordFiltration {
    
    static var words: [String] = []
    static var rootModel: SensitiveWordModel = creatDFAModel()
    
    static func creatDFAModel() -> SensitiveWordModel {
        let root = SensitiveWordModel()
        words = getSentiveWords()
        words.forEach { word in
            var model = root
            for letter in word {
                let letterString = String(letter)
                if model.childrens[letterString] == nil {
                    model.childrens[letterString] = SensitiveWordModel()
                }
                model = model.childrens[letterString]!
            }
            model.word = word
        }
        
        return root
    }
    
    static func getSentiveWords() -> [String] {
        var rootArray = [String]()
        guard let filePath = Bundle.main.path(forResource: "敏感词", ofType: "txt") else {return [String]()}
        guard let filterString = try? String(contentsOfFile: filePath, encoding: .utf8) else {return [String]()}
        rootArray.append(contentsOf: filterString.components(separatedBy: "\n"))
        return rootArray
    }
}


