//
//  DPLogLevel.swift
//  DPLog
//
//  Created by 张鹏 on 2018/4/2.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation


/// 日志打印Level
///
/// - info:     信息，提示信息
/// - warning:  警告，可能存在的威胁
/// - error:    错误，发生错误，但不足以造成程序崩溃
/// - crash:    崩溃，会导致程序崩溃的严重错误
public enum DPLogLevel: Int {
    case all        = -1
    case info       = 0
    case warn       = 1
    case error      = 2
    case crash      = 3
    case none       = 9999
}


// MARK: - DPLogLevel 实现 `CustomStringConvertible` 协议
extension DPLogLevel: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .info:
            return " INFO ℹ️"
        case .warn:
            return " WARN ⚠️"
        case .error:
            return "ERROR ❌"
        case .crash:
            return "CRASH 🆘"
        default:
            return ""
        }
    }
}

// MARK: - DPLogLevel 实现 `Comparable` 协议
extension DPLogLevel: Comparable {
    
    //
    public static func < (lhs: DPLogLevel, rhs: DPLogLevel) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}
