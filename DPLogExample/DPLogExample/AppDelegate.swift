//
//  AppDelegate.swift
//  DPLogExample
//
//  Created by 张鹏 on 2018/4/2.
//  Copyright © 2018年 dancewithpeng@gmail.com. All rights reserved.
//

import UIKit
import DPLog

class MyFormatter: DPLogFormatter {
    func formatString(for info: DPLogInformation) -> String {
        return "\(info.message ?? "nil")"
    }
}

class MyLogger: DPLogger {
    
    var logLevel: DPLogLevel
    
    var formatter: DPLogFormatter
    
    init() {
        self.logLevel = .debug
        self.formatter = MyFormatter()
    }
    
    func log(message: String) {
        print("MyLogger - \(message)")
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        #if DEBUG
        Log.setup(loggers: [DPConsoleLogger(logLevel: .debug)])
        #else
        Log.setup(loggers: [
            DPConsoleLogger(logLevel: .error),
            MyLogger()
        ])
        #endif
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

