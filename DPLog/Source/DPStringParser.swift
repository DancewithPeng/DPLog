//
//  DPStringParser.swift
//  DPLog
//
//  Created by 张鹏 on 2018/3/29.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

// 1. yyyy-MM-dd HH:mm:ss.sss -> 2018-03-29 15:08:33
// 2. P -> 进程ID

/// 字符串解析器
class DPLogFormatParser {
    
    lazy var patterns = [Pattern]()
    
    init() {
        
        // 日期
        patterns.append(DPLogDetePattern(valueKey: "date"))
        
        // 文件
        patterns.append(DPLogDefaultPattern(regex: "&F", valueKey: "file"))
        
        // 函数
        patterns.append(DPLogDefaultPattern(regex: "&f", valueKey: "function"))
        
        // 行数
        patterns.append(DPLogDefaultPattern(regex: "&l", valueKey: "line"))
        
        // 进程名称
        patterns.append(DPLogDefaultPattern(regex: "&P", valueKey: "process"))
        
        // 进程ID
        patterns.append(DPLogDefaultPattern(regex: "&p", valueKey: "processID"))
        
        // 线程
        patterns.append(DPLogDefaultPattern(regex: "&T", valueKey: "thread"))
        
        // 线程ID
        patterns.append(DPLogDefaultPattern(regex: "&t", valueKey: "threadID"))
        
        // log level
        patterns.append(DPLogDefaultPattern(regex: "&L", valueKey: "level"))
        
        // message
        patterns.append(DPLogDefaultPattern(regex: "&m", valueKey: "message"))
        
        // 是否为主线程
        patterns.append(DPLogIsMainThreadPattern(valueKey: "thread"))
    }
    
    func parse(format: String, values: [String: Any]) -> String {
        
        var ret = format
        for pattern in patterns {
            ret = pattern.handle(format: ret, values: values)
        }
        
        return ret
    }
}

protocol Pattern {
    
    var regex: String { get }
    
    var valueKey: String { get }
    
    func handle(format: String, values: [String: Any]) -> String
}

struct DPLogDefaultPattern: Pattern {
    
    let regex: String
    let valueKey: String
    
    func handle(format: String, values: [String : Any]) -> String {
        guard let value = values[valueKey] else {
            return format
        }
        
        return format.replacingOccurrences(of: regex, with: "\(value)", options: .regularExpression)
    }
}

struct DPLogDetePattern: Pattern {
    
    let valueKey: String
    
    var regex: String {
        return "&D.*?&d"
    }
    
    let dateFormatter = DateFormatter()
    
    func handle(format: String, values: [String : Any]) -> String {
        
        guard let date = values[valueKey] as? Date else {
            return format
        }
        
        guard let range = format.range(of: regex, options: .regularExpression) else {
            return format
        }
        
        let dateRange = format.index(range.lowerBound, offsetBy: 2)..<format.index(range.upperBound, offsetBy: -2)
        let dateFormat = String(format[dateRange])
        
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date)
        
        return format.replacingCharacters(in: range, with: dateString)
    }
}

struct DPLogIsMainThreadPattern: Pattern {
    
    let valueKey: String
    
    var regex: String {
        return "&M"
    }
    
    func handle(format: String, values: [String : Any]) -> String {
        guard let thread = values[valueKey] as? Thread else {
            return format
        }
        
        return format.replacingOccurrences(of: regex, with: thread.isMainThread ? "M" : "S", options: .regularExpression)
    }
}
