//
//  AppDelegate.m
//  DPLogExample-ObjC
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "AppDelegate.h"
#import <DPLog/DPLog.h>
#import "DPLogExample_ObjC-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [DPLogCoordinator setup];
    
    return YES;
}

@end
