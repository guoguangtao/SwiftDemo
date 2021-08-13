//
//  StringExtension.swift
//  SwiftDemo
//
//  Created by GGT on 2021/8/11.
//

import Foundation


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
