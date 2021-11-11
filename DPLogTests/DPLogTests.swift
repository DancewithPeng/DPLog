//
//  DPLogTests.swift
//  DPLogTests
//
//  Created by 张鹏 on 2018/3/26.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import XCTest
import DPLog

enum MyError: String, Error {
    case Unknow = "🦋🦋🦋"
    case Crash = "🐯🐯🐯"
}

class DPLogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
                
        let consoleLogger = DPConsoleLogger()
        consoleLogger.logLevel = .verbose
        Log.setup(loggers: [consoleLogger])
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLogInfo() {
        Log.info("Info Message")
    }
    
    func testError() {
        
        enum MyError: Error {
            case unknow
            case ok
            case lalala
        }
        
//        LogError(MyError.unknow)
//        LogError(MyError.ok)
//        LogError(MyError.lalala)
        
        sleep(3)
    }
    
    func testAll() {
//        LogInfo("🐶🐶🐶")
//        LogWarning("🦁🦁🦁")
//        LogError(MyError.Unknow)
//        LogCrash(MyError.Crash)
        
        sleep(3)
    }
    
    func testParser() {        
//        p//    let logger = DPConsoleLogger().parse(data: data)
    }
}
