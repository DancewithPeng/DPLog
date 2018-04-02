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
        
        LogInfo("🐯🐯🐯")
        LogWarn("😅😅😅")
        LogError(MyError.ahahha)
        LogCrash(MyError.okokokok)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

