//
//  DPLogger.swift
//  DPLog
//
//  Created by 张鹏 on 2018/4/2.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 日志打印器，输出的地方：控制台？文件？服务器？
public protocol DPLogger {
    
    /// 标识符
    var identifier: String { get }
    
    /// 日志输出(打印)等级
    var outputLevel: DPLogLevel { get set }
    
    /// 日志输出(打印)队列
    var outputQueue: DispatchQueue { get }
    
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

// MARK: - `DPLogger` 协议 `log(level:, message:)` 方法的默认实现
extension DPLogger {
    
    public func log(level: DPLogLevel, message: String) {
        if level >= outputLevel {
            objc_sync_enter(self)
            outputQueue.async {
                self.output(message: message)
            }
            objc_sync_exit(self)
        }
    }
}
