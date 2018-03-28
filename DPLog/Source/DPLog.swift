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
enum DPLogLevel: Int, CustomStringConvertible, Comparable {
    case info       = 0
    case warning    = 1
    case error      = 2
    case crash      = 3

    var description: String {
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
    
    static func < (lhs: DPLogLevel, rhs: DPLogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}

/// 日志管理器
class DPLogManager {
    
    /// 单例
    static let shared = DPLogManager()
    
    /// 日志格式
    static var format = "$Dyyyy-MM-dd HH:mm:ss.SSS$d $F $f $l $P $p $t $m"
    
    lazy var loggers = Set<DPLogger>()
    
//    /// 添加日志打印器
//    ///
//    /// - Parameter logger: 日志打印器
//    static func add(logger: DPLogger) {
//
//    }
}


func LogInfo(_ info: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let logger = DPConsoleLogger()
    
    /*
    
    //print(tid)
    
    let l1 = DPLogLevel.crash
    let l2 = DPLogLevel.error
    
    if l1 == l2 {
        print("等于")
    }
    
    if l1 < l2 {
        print("小于")
    }
    
    if l1 <= l2 {
        print("小于等于")
    }
    
    if l1 > l2 {
        print("大于")
    }
    
    if l1 >= l2 {
        print("大于等于")
    }
    
    let time = Date().timeIntervalSince1970
    
    print("----------")
    print(date)
    print(time)
 
 */
    let tid = pthread_mach_thread_np(pthread_self())
    
    var message = ""
    if info is String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "zh_CN")
        if let fileName = file.components(separatedBy: "/").last {
            message = "\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread"):\(tid)] \(fileName)[\(line)] \(function) \(DPLogLevel.info) \(info)"
        }
    } else {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        formatter.locale = Locale(identifier: "zh_CN")
        if let fileName = file.components(separatedBy: "/").last {
            message = "\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.info) ⬇⬇⬇ \r\n\(info) \n"
        }
    }
    
    logger.log(level: .info, message: message)
}

func LogWarning(_ warning: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.warning) \(warning)")
    }
}

func LogError(_ error: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.error) \(error)")
    }
}

func LogCrash(_ crash: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    formatter.locale = Locale(identifier: "zh_CN")
    if let fileName = file.components(separatedBy: "/").last {
        print("\(formatter.string(from: date)) \(process.processName)[\(thread.isMainThread ? "MainTread": "SubThread")] \(fileName)[\(line)] \(function) \(DPLogLevel.crash) \(crash)")
    }
}


// hi hello world

// MARK: - Logger

struct DPLogTask {
    var logMessage: String
    
//    func ex
}

/// 日志打印器，输出的地方：控制台？文件？服务器？
protocol DPLogger: Hashable {
    
    /// 日志输出(打印)等级
    var outputLevel: DPLogLevel { get set }
    
    /// 日志输出(打印)队列
    var outputQueue: DispatchQueue { get }
    
    /// 输出(打印)操作
    ///
    /// - Parameter message: 需要输出(打印)的日志信息
    func output(message: String)
    
    
    /// 输出(打印)日志信息，此方法已在extension中实现
    ///
    /// - Parameters:
    ///   - level:   需要输出(打印)的日志等级
    ///   - message: 需要输出(打印)的日志信息
    func log(level: DPLogLevel, message: String)
}

extension DPLogger {
    func log(level: DPLogLevel, message: String) {
        if level >= outputLevel {
            self.outputQueue.async {
                self.output(message: message)
            }
        }
    }
}


/// 控制台打印器
class DPConsoleLogger: DPLogger {
    
    var outputLevel: DPLogLevel = .warning
    
    lazy var outputQueue: DispatchQueue = DispatchQueue(label: "DPConsoleLoggerQueue", qos: .default, attributes: DispatchQueue.Attributes.concurrent)
    
    func output(message: String) {
        print(message)
    }
    
    var hashValue: Int {
        return outputQueue.hashValue
    }
    
    static func ==(lhs: DPConsoleLogger, rhs: DPConsoleLogger) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

//
//class DPFileLogger: DPLogger {
//    var outputLevel: DPLogLevel = .error
//}

