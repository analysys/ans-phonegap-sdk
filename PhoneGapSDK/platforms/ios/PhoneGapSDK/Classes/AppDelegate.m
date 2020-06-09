/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  AppDelegate.m
//  PhoneGapSDK
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"

#import <AnalysysAgent/AnalysysAgent.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions
{
    self.viewController = [[MainViewController alloc] init];
    
    
    [self _initAnalysysSDKWithOptions:launchOptions];
    
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)_initAnalysysSDKWithOptions:(NSDictionary *)launchOptions {
    CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();

    //  AnalysysAgent SDK配置信息
    AnalysysConfig.appKey = @"heatmaptest0916";
    AnalysysConfig.channel = @"App Store";
    //  使用配置信息初始化SDK
    [AnalysysAgent startWithConfig:AnalysysConfig];
    
    
    #if DEBUG
        [AnalysysAgent setDebugMode:AnalysysDebugButTrack];
    #else
        [AnalysysAgent setDebugMode:AnalysysDebugOff];
    #endif

    [AnalysysAgent setUploadURL:@"https://arkpaastest.analysys.cn:4089"];
    
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    NSLog(@"The code execution time %f ms", linkTime *1000.0);
}

@end
