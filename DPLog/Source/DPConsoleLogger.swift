//
//  DPConsoleLogger.swift
//  DPLog
//
//  Created by 张鹏 on 2018/4/2.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation

/// 控制台打印器
public class DPConsoleLogger: DPLogger {
    
    public init() {}
    
    public var identifier: String = "DPConsoleLogger"
    
    public var outputLevel: DPLogLevel = .info
    
    public var format: String?
    
    public lazy var outputQueue: DispatchQueue = DispatchQueue(label: "DPConsoleLoggerQueue", qos: .default, attributes: DispatchQueue.Attributes.concurrent)
    
    public func output(message: String) {        
        print("\(message)")
    }
}
