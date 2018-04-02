//
//  DPLog.swift
//  DPLog
//
//  Created by 张鹏 on 2018/3/26.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation
import Darwin

/// 打印信息
public func LogInfo(_ info: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
    
    DPLogManager.log(level: .info, obj: info, file: file, function: function, line: line, date: date, process: process, thread: thread, threadID: threadID)
}

/// 打印警告
public func LogWarn(_ warn: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
    
    DPLogManager.log(level: .warn, obj: warn, file: file, function: function, line: line, date: date, process: process, thread: thread, threadID: threadID)
}

/// 打印错误
public func LogError(_ error: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
    
    DPLogManager.log(level: .error, obj: error, file: file, function: function, line: line, date: date, process: process, thread: thread, threadID: threadID)
}

/// 打印崩溃
public func LogCrash(_ crash: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current, threadID: UInt32 = pthread_mach_thread_np(pthread_self())) {
    
    DPLogManager.log(level: .crash, obj: crash, file: file, function: function, line: line, date: date, process: process, thread: thread, threadID: threadID)
}


/// 日志管理器，用于设置DPLog的相关配置
public class DPLogManager {
    
    /// 单例
    static let shared = DPLogManager()
    
    /// 打印器集合，输出不同的终端需要不同的打印器
    private lazy var loggers = [DPLogger]()
    
    /// 日志打印队列
    private lazy var logQueue = DispatchQueue(label: "DPLogManagerLogQueue", qos: DispatchQoS.default)
    
    /// 日志打印格式，可定制
    static var format = "&DHH:mm:ss.SSS&d &M[&t] &F[&l] &f &L &m"
    
    /// 日志格式解析器，可定制
    static var logFormatParser: DPLogFormatParser = DPDefaultLogFormatParser()
    
    
    /// 添加日志打印器，类方法
    ///
    /// - Parameter logger: 日志打印器
    public static func addLogger(_ logger: DPLogger) {
        shared.addLogger(logger)
    }
    
    /// 添加日志打印器，实例方法
    ///
    /// - Parameter logger: 日志打印器
    private func addLogger(_ logger: DPLogger) {
        if !loggers.contains(where: { $0.identifier == logger.identifier }) {
            loggers.append(logger)
        }
    }
    
    /// 打印日志，类方法
    ///
    /// - Parameters:
    ///   - level:      Log Level
    ///   - obj:        打印的对象
    ///   - file:       所在的文件
    ///   - function:   所在的函数
    ///   - line:       所在的行数
    ///   - date:       打印的时间
    ///   - process:    所在的进程
    ///   - thread:     所在的线程
    fileprivate static func log(level: DPLogLevel, obj: Any, file: String, function: String, line: Int, date: Date, process: ProcessInfo, thread: Thread, threadID: UInt32) {
        shared.log(level: level, obj: obj, file: file, function: function, line: line, date: date, process: process, thread: thread, threadID: threadID)
    }
    
    /// 打印日志，实例方法
    ///
    /// - Parameters:
    ///   - level:      Log Level
    ///   - obj:        打印的对象
    ///   - file:       所在的文件
    ///   - function:   所在的函数
    ///   - line:       所在的行数
    ///   - date:       打印的时间
    ///   - process:    所在的进程
    ///   - thread:     所在的线程
    private func log(level: DPLogLevel, obj: Any, file: String, function: String, line: Int, date: Date, process: ProcessInfo, thread: Thread, threadID: UInt32) {
        
        objc_sync_enter(self)
        
        logQueue.async {
            
            // 处理文件名
            var fileName = file
            if let f = file.components(separatedBy: "/").last {
                fileName = f
            }
            
            // 参数集合
            let params: [DPLogParam] = [
                .level(level),
                .message(obj),
                .file(fileName),
                .line(line),
                .function(function),
                .date(date),
                .process(process),
                .processID(process.processIdentifier),
                .thread(thread),
                .threadID(threadID),
                .isMainThread(thread.isMainThread),
                ]
            
            objc_sync_enter(self)
            
            // 打印器打印日志
            for logger in self.loggers {
                
                // 解析日志格式
                var message = ""
                if let loggerFormat = logger.format {
                    message = DPLogManager.logFormatParser.parse(format: loggerFormat, params: params)
                } else {
                    message = DPLogManager.logFormatParser.parse(format: DPLogManager.format, params: params)
                }
                
                // 打印解析好的格式
                logger.log(level: level, message: message)
            }
            
            objc_sync_exit(self)
        }
        
        objc_sync_exit(self)
    }
}


/// DPLog获取当前行的参数
///
/// - level:        Log level
/// - message:      打印的信息
/// - file:         所在的文件
/// - line:         所在的行数
/// - function:     所在的函数
/// - date:         调用的时间
/// - process:      调用的进程
/// - processID:    调用的进程ID
/// - thread:       调用的线程
/// - threadID:     调用的线程ID
/// - isMainThread: 是否是在主线程
public enum DPLogParam {
    case level(DPLogLevel)
    case message(Any)
    case file(String)
    case line(Int)
    case function(String)
    case date(Date)
    case process(ProcessInfo)
    case processID(Int32)
    case thread(Thread)
    case threadID(UInt32)
    case isMainThread(Bool)
}

