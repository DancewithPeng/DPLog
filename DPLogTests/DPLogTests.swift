//
//  DPLogTests.swift
//  DPLogTests
//
//  Created by 张鹏 on 2018/3/26.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import XCTest
import DPLog

typealias Log = HandyLog

enum MyError: String, Error {
    case Unknow = "🦋🦋🦋"
    case Crash  = "🐯🐯🐯"
}

class DPLogTests: XCTestCase {
    
    override func setUpWithError() throws {
        guard DPLog.Collector.shared.handlers.contains(where: { $0.id == "DPLog.ConsoleHandler" }) == false else {
            return
        }
        
        try DPLog.Collector.shared.register(DPLog.ConsoleHandler(id: "DPLog.ConsoleHandler",
                                                                 level: .verbose,
                                                                 formatter: DPLog.PlainMessageFormatter()))
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
        
        Log.error(MyError.unknow)
        Log.error(MyError.ok)
        Log.error(MyError.lalala)
        
        sleep(3)
    }
    
    func testAll() {
        Log.debug(MyError.Crash)
        Log.info("🐶🐶🐶")
        Log.warning("🦁🦁🦁")
        Log.error(MyError.Unknow)
        
        sleep(3)
    }
}
