//
//  DPLog.swift
//  DPLog
//
//  Created by 张鹏 on 2018/3/26.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation
import Darwin

// 1.一个结构
// 2.能表示参数类型
// 3.同时能表示参数值
// 4.对应解析的正则表达式

// 结构体
//struct Params {
//    var file: (String, String)?
//}

//let p = Params()
//p.file =

// 枚举
enum DPLogParams {
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


/// 日志格式解析器
protocol LogFormatParser {
    
    /// 解析格式，根据指定参数，解析格式，并返回解析后的字符串
    ///
    /// - Parameters:
    ///   - format: 格式
    ///   - params: 对应的参数
    /// - Returns: 返回解析后的字符串
    func parse(format: String, params: [DPLogParams]) -> String
    
    
    /// 返回参数对应的匹配正则表达式
    ///
    /// - Parameter param: 参数
    /// - Returns: 返回参数对应的匹配正则表达式
    func pattern(forParam param: DPLogParams) -> String
    
    
    /// 处理匹配的正则表达式
    ///
    /// - Parameters:
    ///   - pattern: 需要处理的匹配正则表达式
    ///   - param: 参数
    /// - Returns: 返回处理过的字符串
    func processPattern(pattern: String, param: DPLogParams) -> String
    
    
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
}

extension LogFormatParser {
    
    func parse(format: String, params: [DPLogParams]) -> String {
        
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
    
    func pattern(forParam param: DPLogParams) -> String {
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
    
    func processPattern(pattern: String, param: DPLogParams) -> String {
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

class MyFormatParser: LogFormatParser {
    
    lazy var dateFormatter = DateFormatter()
    
    let levelPattern: String        = "&L"
    let messagePattern: String      = "&m"
    let filePattern: String         = "&F"
    let linePattern: String         = "&l"
    let functionPattern: String     = "&f"
    let datePattern: String         = "&D.*?&d"
    let processPattern: String      = "&P"
    let processIDPattern: String    = "&p"
    let threadPattern: String       = "&T"
    let threadIDPattern: String     = "&t"
    let isMainThreadPattern: String = "&M"
    
    func processLevelPattern(pattern: String, level: DPLogLevel) -> String {
        return "\(level)"
    }
    
    func processMessagePattern(pattern: String, message: Any) -> String {
        return "\(message)"
    }
    
    func processFilePattern(pattern: String, file: String) -> String {
        return "\(file)"
    }
    
    func processLinePattern(pattern: String, line: Int) -> String {
        return "\(line)"
    }
    
    func processFunctionPattern(pattern: String, function: String) -> String {
        return "\(function)"
    }
    
    func processDatePattern(pattern: String, date: Date) -> String {
        
        let dateRange = pattern.index(pattern.startIndex, offsetBy: 2)..<pattern.index(pattern.endIndex, offsetBy: -2)
        let dateFormat = String(pattern[dateRange])
        
        dateFormatter.dateFormat = dateFormat
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    func processProcessPattern(pattern: String, process: ProcessInfo) -> String {
        return "\(process.processName)"
    }
    
    func processProcessIDPattern(pattern: String, processID: Int32) -> String {
        return "\(processID)"
    }
    
    func processThreadPattern(pattern: String, thread: Thread) -> String {
        return thread.name==nil ? "\(thread)" : thread.name!
    }
    
    func processThreadIDPattern(pattern: String, threadID: UInt32) -> String {
        return "\(threadID)"
    }
    
    func processIsMainThreadPattern(pattern: String, isMainThread: Bool) -> String {
        return isMainThread ? "M" : "S"
    }
}





//// 日期
//patterns.append(DPLogDetePattern(valueKey: "date"))
//
//// 文件
//patterns.append(DPLogDefaultPattern(regex: "&F", valueKey: "file"))
//
//// 函数
//patterns.append(DPLogDefaultPattern(regex: "&f", valueKey: "function"))
//
//// 行数
//patterns.append(DPLogDefaultPattern(regex: "&l", valueKey: "line"))
//
//// 进程名称
//patterns.append(DPLogDefaultPattern(regex: "&P", valueKey: "process"))
//
//// 进程ID
//patterns.append(DPLogDefaultPattern(regex: "&p", valueKey: "processID"))
//
//// 线程
//patterns.append(DPLogDefaultPattern(regex: "&T", valueKey: "thread"))
//
//// 线程ID
//patterns.append(DPLogDefaultPattern(regex: "&t", valueKey: "threadID"))
//
//// log level
//patterns.append(DPLogDefaultPattern(regex: "&L", valueKey: "level"))
//
//// message
//patterns.append(DPLogDefaultPattern(regex: "&m", valueKey: "message"))
//
//// 是否为主线程
//patterns.append(DPLogIsMainThreadPattern(valueKey: "thread"))

//_ info: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current


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
    
    /// 打印器集合
    private lazy var loggers = [DPLogger]()
    
    /// 默认格式
    static var format = "&DHH:mm:ss.SSS&d &M[&t] &F[&l] &f &L &m"
    
    lazy var logFormatParser: LogFormatParser = MyFormatParser()
    
    /// 添加日志打印器
    ///
    /// - Parameter logger: 日志打印器
    func add(logger: DPLogger) {
        if !loggers.contains(where: { $0.identifier == logger.identifier }) {
            loggers.append(logger)
        }
    }
    
    func log(level: DPLogLevel, obj: Any, file: String, function: String, line: Int, date: Date, process: ProcessInfo, thread: Thread) {
        
        let threadID = pthread_mach_thread_np(pthread_self())
        
        var fileName = file
        if let f = file.components(separatedBy: "/").last {
            fileName = f
        }
        
        let params: [DPLogParams] = [
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
        
        for logger in loggers {
            var message = ""
            if let loggerFormat = logger.format {
                message = logFormatParser.parse(format: loggerFormat, params: params)
            } else {
                message = logFormatParser.parse(format: DPLogManager.format, params: params)
            }
            
            logger.log(level: level, message: message)
        }
    }
}

//info: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current

/// 日志格式数据
struct DPLogFormatData {
    var file: String            // 文件
    var line: Int               // 行数
    var function: String        // 函数
    var date: Date              // 日期
    var process: ProcessInfo    // 进程
    var thread: Thread          // 线程
    var threadID: UInt32        // 线程ID
}

/// 日志格式规则
struct DPLogFormatRule {
    
    let regex: String
    
    func apply(value: Any) -> String {
        return "\(value)"
    }
}

func LogInfo(_ info: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    DPLogManager.shared.log(level: .info, obj: info, file: file, function: function, line: line, date: date, process: process, thread: thread)
}

func LogWarning(_ warning: Any, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    DPLogManager.shared.log(level: .warning, obj: warning, file: file, function: function, line: line, date: date, process: process, thread: thread)
}

func LogError(_ error: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {

    DPLogManager.shared.log(level: .error, obj: error, file: file, function: function, line: line, date: date, process: process, thread: thread)
}

func LogCrash(_ crash: Error, file: String = #file, function: String = #function, line: Int = #line, date: Date = Date(), process: ProcessInfo = ProcessInfo.processInfo, thread: Thread = Thread.current) {
    
    DPLogManager.shared.log(level: .crash, obj: crash, file: file, function: function, line: line, date: date, process: process, thread: thread)
}


// hi hello world

// MARK: - Logger

struct DPLogTask {
    var logMessage: String
    
//    func ex
}

/// 日志打印器，输出的地方：控制台？文件？服务器？
protocol DPLogger {
    
    /// 标识符
    var identifier: String { get }
    
    /// 日志输出(打印)等级
    var outputLevel: DPLogLevel { get set }
    
    /// 日志输出(打印)队列
    var outputQueue: DispatchQueue { get }
    
    /// 日志格式解析器
    var formatParser: DPLogFormatParser { get }
    
    /// 日志格式
    var format: String? { get }
    
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
    
    var identifier: String = "DPConsoleLogger"
    
    var outputLevel: DPLogLevel = .info
    
    let formatParser: DPLogFormatParser = DPLogFormatParser()
    
    var format: String?
    
    lazy var outputQueue: DispatchQueue = DispatchQueue(label: "DPConsoleLoggerQueue", qos: .default, attributes: DispatchQueue.Attributes.concurrent)
    
    func output(message: String) {
        print("\n\(message)")
    }
}

//
//class DPFileLogger: DPLogger {
//    var outputLevel: DPLogLevel = .error
//}

