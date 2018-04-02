//
//  DPLogTests.swift
//  DPLogTests
//
//  Created by 张鹏 on 2018/3/26.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import XCTest
@testable import DPLog

enum MyError: String, Error {
    case Unknow = "🦋🦋🦋"
    case Crash = "🐯🐯🐯"
}

class DPLogTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let consoleLogger = DPConsoleLogger()
        consoleLogger.outputLevel = .all
        DPLogManager.addLogger(consoleLogger)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testLogInfo() {
        
        for _ in 0..<5 {
            DispatchQueue.global().async {
                LogInfo("Hello World")
            }
        }
        
//        for _ in 0..<3 {
//            LogInfo("Main Message")
//        }
        
        sleep(3)
    }
    
    func testError() {
        
        enum MyError: Error {
            case unknow
            case ok
            case lalala
        }
        
        LogError(MyError.unknow)
        LogError(MyError.ok)
        LogError(MyError.lalala)
        
        sleep(3)
    }
    
    func testAll() {
        LogInfo("🐶🐶🐶")
        LogWarning("🦁🦁🦁")
        LogError(MyError.Unknow)
        LogCrash(MyError.Crash)
        
        sleep(3)
    }
    
    func testParser() {        
//        p//    let logger = DPConsoleLogger().parse(data: data)
    }
}
