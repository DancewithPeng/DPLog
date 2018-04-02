//
//  DPDefaultLogFormatParser.swift
//  DPLog
//
//  Created by 张鹏 on 2018/4/2.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation


/// 默认格式解析器
public class DPDefaultLogFormatParser : DPLogFormatParser {
    
    /// 日期格式
    lazy var dateFormatter = DateFormatter()
    
    
    // MARK: - 实现 `DPLogFormatParser` 协议
    
    public let levelPattern: String        = "&L"
    public let messagePattern: String      = "&m"
    public let filePattern: String         = "&F"
    public let linePattern: String         = "&l"
    public let functionPattern: String     = "&f"
    public let datePattern: String         = "&D.*?&d"
    public let processPattern: String      = "&P"
    public let processIDPattern: String    = "&p"
    public let threadPattern: String       = "&T"
    public let threadIDPattern: String     = "&t"
    public let isMainThreadPattern: String = "&M"
    
    public func processLevelPattern(pattern: String, level: DPLogLevel) -> String {
        return "\(level)"
    }
    
    public func processMessagePattern(pattern: String, message: Any) -> String {
        
        if message is Error {
            return "\(type(of: message)).\(message)"
        }
        
        return "\(message)"
    }
    
    public func processFilePattern(pattern: String, file: String) -> String {
        return "\(file)"
    }
    
    public func processLinePattern(pattern: String, line: Int) -> String {
        return "\(line)"
    }
    
    public func processFunctionPattern(pattern: String, function: String) -> String {
        return "\(function)"
    }
    
    public func processDatePattern(pattern: String, date: Date) -> String {

        let dateRange = pattern.index(pattern.startIndex, offsetBy: 2)..<pattern.index(pattern.endIndex, offsetBy: -2)
        let dateFormat = String(pattern[dateRange])
        
        objc_sync_enter(dateFormatter)
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date)
        objc_sync_exit(dateFormatter)
        
        return dateString
    }
    
    public func processProcessPattern(pattern: String, process: ProcessInfo) -> String {
        return "\(process.processName)"
    }
    
    public func processProcessIDPattern(pattern: String, processID: Int32) -> String {
        return "\(processID)"
    }
    
    public func processThreadPattern(pattern: String, thread: Thread) -> String {
        return thread.name==nil ? "\(thread)" : thread.name!
    }
    
    public func processThreadIDPattern(pattern: String, threadID: UInt32) -> String {
        return "\(threadID)"
    }
    
    public func processIsMainThreadPattern(pattern: String, isMainThread: Bool) -> String {
        return isMainThread ? "M" : "S"
    }
}
