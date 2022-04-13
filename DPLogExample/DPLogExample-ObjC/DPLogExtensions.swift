//
//  DPLogExtensions.swift
//  DPLogExample-ObjC
//
//  Created by 张鹏 on 2022/4/12.
//  Copyright © 2022 dancewithpeng@gmail.com. All rights reserved.
//

import Foundation
import DPLog

@objc
final class DPLogCoordinator: NSObject {
    
    @objc
    static func setup() {
        do {
            try DPLog.Collector.shared.register(
                    DPLog.ConsoleHandler(
                        id: "DPLogExample.ConsoleHandler",
                        level: .verbose,
                        formatter: DPLog.PlainMessageFormatter()
                    )
                )
        } catch {
            print(error)
        }
    }
}
