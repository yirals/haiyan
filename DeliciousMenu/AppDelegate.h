//
//  AppDelegate.h
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//fromsearchpath  /DeliciousMenu/Library

//$(inherited) $(PROJECT_DIR)/DeliciousMenu/Library/ThirdWays/libWeiboSDK
// $(PROJECT_DIR)/DeliciousMenu/Library/ThirdWays

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSString *wbtoken;
@property(nonatomic, strong) UITabBarController *tableBar;

@end

