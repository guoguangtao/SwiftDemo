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

extension String {
    
    /// 字符串敏感词过滤
    /// - Parameter replaceString: 替换敏感词字符串
    /// - Returns: 返回过滤结果
    func gyhs_filter(replaceString: String) -> FilterResult {
        
        var isContain = false
        var filteredText = self
        
        for i in 0 ..< self.count {
            var model = SensitiveWordFiltration.rootModel
            var j = i
            while j < self.count, model.childrens[String(self[j])] != nil {
                model = model.childrens[String(self[j])]!
                j += 1
            }
            
            if !model.word.isEmpty && model.word == self.gyhs_subString(from: i, to: (j - 1)) {
                var replaceStr = ""
                isContain = true
                for _ in i ..< j {
                    replaceStr.append(replaceString)
                }
                filteredText = filteredText.replacingOccurrences(of: model.word, with: replaceStr)
            }
        }
        
        return (isContain, filteredText)
    }
    
    /// 按照下标截取字符串
    /// - Parameters:
    ///   - from: 开始位置下标
    ///   - to: 结束位置下标
    /// - Returns: 返回符合条件的字符串，否则返回 ""
    func gyhs_subString(from: Int, to: Int) -> String {
        guard from >= 0,
              from < self.count,
              to >= from,
              to < self.count else {
            return ""
        }
        
        let s = index(startIndex, offsetBy: from)
        let e = index(startIndex, offsetBy: to)
        return String(self[s...e])
    }
    
    subscript(index: Int) -> String {
        
        return gyhs_subString(from: index, to: index)
    }
}


