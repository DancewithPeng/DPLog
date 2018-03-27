//
//  DPLog.swift
//  DPLog
//
//  Created by 张鹏 on 2018/3/26.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation
import Darwin


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
    //
    func description() -> String {
        switch self {
        case .info:
            return " INFO ℹ️"
        case .warning:
            return " WARN ⚠️"
        case .error:
            return "ERROR ❌"
        case .crash:
            return "CRASH 🆘"
        }
    }
}

func LogInfo(_ info: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let tid = pthread_mach_thread_np(pthread_self())
    print(tid)
    if info is String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "zh_CN")
        if let fileName = file.components(separatedBy: "/").last {
            print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread"):\(tid)] \(fileName)[\(line)] \(function) \(DPLogLevel.info.description()) \(info)")
        }
    } else {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
        formatter.locale = Locale(identifier: "zh_CN")
        if let fileName = file.components(separatedBy: "/").last {
            print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.info.description()) ⬇⬇⬇ \r\n\(info) \n")
        }
    }
}

func LogWarning(_ warning: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.warning.description()) \(warning)")
    }
}

func LogError(_ error: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.error.description()) \(error)")
    }
}

func LogCrash(_ crash: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSS"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.crash.description()) \(crash)")
    }
}
