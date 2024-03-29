//
//  ViewController.swift
//  DPLogExample
//
//  Created by 张鹏 on 2018/4/2.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPLog

enum MyError: Error {
    case ahahha
    case okokokok
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Log.error("My Error")
        Log.debug("My Debug")
        Log.warning("My Warning")
        Log.info("My Info")
        Log.error(MyError.okokokok)
        
        let error = NSError(domain: "dp.log.demo",
                            code: 100001,
                            userInfo: [NSLocalizedFailureReasonErrorKey: "Error Demo",
                                       NSLocalizedDescriptionKey: "Just a Demo"])
        Log.error(error)
        
        ViewController.demo()
        
        DispatchQueue.concurrentPerform(iterations: 10) { (index) in
            guard let l = [DPLog.Message.Level.debug, DPLog.Message.Level.info, DPLog.Message.Level.warning, DPLog.Message.Level.error].randomElement() else {
                return
            }
            
            switch l {
            case .debug:
                Log.debug("并发-DEBUG")
            case .info:
                Log.info("并发-INFO")
            case .warning:
                Log.warning("并发-WARNING")
            case .error:
                Log.error("并发-ERROR")
            }
        }
    }
    
    class func demo() {
        Log.debug("测试一下下")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

