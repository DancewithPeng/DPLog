//
//  DPLog.swift
//  DPLog
//
//  Created by 张鹏 on 2018/3/26.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation


/// 日志Level
///
/// - info:     信息，提示信息
/// - warning:  警告，可能存在的威胁
/// - error:    错误，发生错误，但不足以造成程序崩溃
/// - crash:    崩溃，会导致程序崩溃的严重错误
enum DPLogLevel {
    case info
    case warning
    case error
    case crash
    
    
//    ❤️🧡💛💚💙💜🖤💔
    func description() -> String {
        switch self {
        case .info:
            return "💜"
        case .warning:
            return "💛"
        case .error:
            return "❤️"
        case .crash:
            return "💔"
        }
    }
}

func LogInfo(_ info: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sss"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.info.description()) \(info)")
    }
}

func LogWarning(_ warning: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sss"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.warning.description()) \(warning)")
    }
}

func LogError(_ error: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sss"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.error.description()) \(error)")
    }
}

func LogCrash(_ crash: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sss"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.crash.description()) \(crash)")
    }
}
