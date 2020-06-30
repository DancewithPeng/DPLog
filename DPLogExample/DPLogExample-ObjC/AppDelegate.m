//
//  AppDelegate.m
//  DPLogExample-ObjC
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "AppDelegate.h"
#import <DPLog/DPLog.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    DPLogDefaultFormatter *defaultFormatter = [[DPLogDefaultFormatter alloc] initWithDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
#ifdef DEBUG
    [DPLog setupWithLoggers:@[
        [[DPConsoleLogger alloc] initWithLogLevel:DPLogLevelDebug formatter:defaultFormatter],
    ]];
#else
    [DPLog setupWithLoggers:@[
        [[DPConsoleLogger alloc] initWithLogLevel:DPLogLevelError formatter:defaultFormatter],
    ]];
#endif
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
