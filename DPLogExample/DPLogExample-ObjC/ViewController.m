//
//  ViewController.m
//  DPLogExample-ObjC
//
//  Created by 张鹏 on 2020/6/29.
//  Copyright © 2020 dancewithpeng@gmail.com. All rights reserved.
//

#import "ViewController.h"
#import <DPLog/DPLog.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DPLogError(@"Hello World");
    NSError *error = [NSError errorWithDomain:@"dp.demo.test"
                                         code:10086
                                     userInfo:@{NSLocalizedFailureReasonErrorKey: @"测试啊",
                                                NSLocalizedDescriptionKey: @"哈哈哈"}];
    DPLogError(error);
    DPLogDebug(@"啊哈哈");
    DPLogInfo(@"阿啦啦啦");
    DPLogWarning(@"asdf");
}

@end
