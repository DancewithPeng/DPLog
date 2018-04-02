//
//  DPLogFormatParser.swift
//  DPLog
//
//  Created by 张鹏 on 2018/4/2.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation


/// 日志格式解析器
public protocol DPLogFormatParser {
    
    // 表示格式的正则表达式
    var levelPattern: String { get }
    var messagePattern: String { get }
    var filePattern: String { get }
    var linePattern: String { get }
    var functionPattern: String { get }
    var datePattern: String { get }
    var processPattern: String { get }
    var processIDPattern: String { get }
    var threadPattern: String { get }
    var threadIDPattern: String { get }
    var isMainThreadPattern: String { get }
    
    // 处理方法
    func processLevelPattern(pattern: String, level: DPLogLevel) -> String
    func processMessagePattern(pattern: String, message: Any) -> String
    func processFilePattern(pattern: String, file: String) -> String
    func processLinePattern(pattern: String, line: Int) -> String
    func processFunctionPattern(pattern: String, function: String) -> String
    func processDatePattern(pattern: String, date: Date) -> String
    func processProcessPattern(pattern: String, process: ProcessInfo) -> String
    func processProcessIDPattern(pattern: String, processID: Int32) -> String
    func processThreadPattern(pattern: String, thread: Thread) -> String
    func processThreadIDPattern(pattern: String, threadID: UInt32) -> String
    func processIsMainThreadPattern(pattern: String, isMainThread: Bool) -> String
    
    
    /// 解析格式，根据指定参数，解析格式，并返回解析后的字符串
    /// 此方法有默认实现
    ///
    /// - Parameters:
    ///   - format: 格式
    ///   - params: 对应的参数
    /// - Returns: 返回解析后的字符串
    func parse(format: String, params: [DPLogParam]) -> String
    
    
    /// 返回参数对应的匹配正则表达式
    /// 此方法有默认实现
    ///
    /// - Parameter param: 参数
    /// - Returns: 返回参数对应的匹配正则表达式
    func pattern(forParam param: DPLogParam) -> String
    
    
    /// 处理匹配的正则表达式
    /// 此方法有默认实现
    ///
    /// - Parameters:
    ///   - pattern: 需要处理的匹配正则表达式
    ///   - param: 参数
    /// - Returns: 返回处理过的字符串
    func processPattern(pattern: String, param: DPLogParam) -> String
}


// MARK: - `DPLogFormatParser` 协议中，三个方法的默认实现
extension DPLogFormatParser {
    
    public func parse(format: String, params: [DPLogParam]) -> String {
        
        var ret = format
        
        for param in params {
            let ptn: String = pattern(forParam: param)
            if let range = ret.range(of: ptn, options: .regularExpression) {
                let ptnStr = ret[range]
                let processedPtnStr = processPattern(pattern: String(ptnStr), param: param)
                ret = ret.replacingCharacters(in: range, with: processedPtnStr)
            }
        }
        
        return ret
    }
    
    public func pattern(forParam param: DPLogParam) -> String {
        switch param {
        case .level:
            return levelPattern
        case .message:
            return messagePattern
        case .file:
            return filePattern
        case .line:
            return linePattern
        case .function:
            return functionPattern
        case .date:
            return datePattern
        case .process:
            return processPattern
        case .processID:
            return processIDPattern
        case .thread:
            return threadPattern
        case .threadID:
            return threadIDPattern
        case .isMainThread:
            return isMainThreadPattern
        }
    }
    
    public func processPattern(pattern: String, param: DPLogParam) -> String {
        switch param {
        case .level(let level):
            return processLevelPattern(pattern: pattern, level: level)
        case .message(let msg):
            return processMessagePattern(pattern: pattern, message: msg)
        case .file(let file):
            return processFilePattern(pattern: pattern, file: file)
        case .line(let line):
            return processLinePattern(pattern: pattern, line: line)
        case .function(let function):
            return processFunctionPattern(pattern: pattern, function: function)
        case .date(let date):
            return processDatePattern(pattern: pattern, date: date)
        case .process(let process):
            return processProcessPattern(pattern: pattern, process: process)
        case .processID(let processID):
            return processProcessIDPattern(pattern: pattern, processID: processID)
        case .thread(let thread):
            return processThreadPattern(pattern: pattern, thread: thread)
        case .threadID(let threadID):
            return processThreadIDPattern(pattern: pattern, threadID: threadID)
        case .isMainThread(let isMainThread):
            return processIsMainThreadPattern(pattern: pattern, isMainThread: isMainThread)
        }
    }
}
