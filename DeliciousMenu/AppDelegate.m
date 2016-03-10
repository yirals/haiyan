//
//  AppDelegate.m
//  DeliciousMenu
//
//  Created by scjy on 16/3/3.
//  Copyright © 2016年 刘海艳. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "SpecialViewController.h"
#import "NewViewController.h"
#import <BmobSDK/Bmob.h>
#import "WeiboSDK.h"
//#import ""

#import "WXApi.h"


@interface AppDelegate ()<WeiboSDKDelegate,WBHttpRequestDelegate,WXApiDelegate>

@end


@implementation AppDelegate

//@synthesize wbtoken;
@synthesize wbtoken;
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [Bmob registerWithAppKey:@"57b6706af8d693d70542b1e63d7a4cff"];
    
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:kAppKey];
    
    //微信分享
    [WXApi registerApp:kWXAppID];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UITabBarController *tabBar = [[UITabBarController alloc] init];
    self.tableBar = [[UITabBarController alloc] init];
    ViewController *mainVC = [[ViewController alloc] init];
    //    self.tableBar.
    UINavigationController *ViewNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
    ViewNav.tabBarItem.title = @"首页";
    ViewNav.tabBarController.title = @"首页";
    ViewNav.tabBarItem.image = [UIImage imageNamed:@"53-house"];
    NewViewController *newVC = [[NewViewController alloc] init];
    UINavigationController *newViewNav = [[UINavigationController alloc] initWithRootViewController:newVC];
    newVC.tabBarItem.title = @"生鲜";
    newVC.tabBarController.title = @"生鲜";
    
    newVC.tabBarItem.image = [UIImage imageNamed:@"02-redo-1"];
    
    MainViewController *mineVC = [[MainViewController alloc] init];
    UINavigationController *MainViewNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    MainViewNav.tabBarItem.title = @"个人";
    MainViewNav.tabBarController.title = @"个人";
    MainViewNav.tabBarItem.image = [UIImage imageNamed:@"29-heart-1"];
    
    SpecialViewController *specialVC = [[SpecialViewController alloc] init];
    UINavigationController *SpecialViewNav = [[UINavigationController alloc] initWithRootViewController:specialVC];
    specialVC.tabBarItem.title = @"专题";
    specialVC.tabBarController.title = @"专题";
    specialVC.tabBarItem.image = [UIImage imageNamed:@"20-gear2-1"];
    
    tabBar.viewControllers = @[ViewNav,newViewNav,SpecialViewNav,MainViewNav];
    tabBar.delegate = self;
    tabBar.tabBar.tintColor = [UIColor orangeColor];
    tabBar.tabBar.barTintColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
    self.window.rootViewController = tabBar;
    self.window.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:235/255.0];
    
    return YES;
}

#pragma mark --------------------集成微博方法


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
        
    }else if ([WeiboSDK handleOpenURL:url delegate:self]){
        return YES;
    }else
    

        return YES;
   
}


- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    
    if ([WXApi handleOpenURL:url delegate:self]) {
        return YES;
    }else if ([WeiboSDK handleOpenURL:url delegate:self]){
        return YES;
    }else
        return YES;
//    return [WeiboSDK handleOpenURL:url delegate:self];
    
}

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
}

-(void)didReceiveWeiboResponse:(WBBaseResponse *)response{
    AppDelegate *myDelegate =(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [WeiboSDK logOutWithToken:myDelegate.wbtoken delegate:self withTag:@"user1"];
    
}


////集成微信方法；
//-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
//    
//    return [WXApi handleOpenURL:url delegate:self];
//}
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
//    
//    return [WXApi handleOpenURL:url delegate:self];
//}
//

- (void)applicationWillResignActive:(UIApplication *)application {

    
    
    
    

    
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
