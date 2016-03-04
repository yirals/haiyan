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


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
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
    
    newVC.tabBarItem.image = [UIImage imageNamed:@"53-house"];
    
    MainViewController *mineVC = [[MainViewController alloc] init];
    UINavigationController *MainViewNav = [[UINavigationController alloc] initWithRootViewController:mineVC];
    MainViewNav.tabBarItem.title = @"个人";
    MainViewNav.tabBarController.title = @"个人";
    MainViewNav.tabBarItem.image = [UIImage imageNamed:@"53-house"];
    
    SpecialViewController *specialVC = [[SpecialViewController alloc] init];
    UINavigationController *SpecialViewNav = [[UINavigationController alloc] initWithRootViewController:specialVC];
    specialVC.tabBarItem.title = @"专题";
    specialVC.tabBarController.title = @"专题";
    specialVC.tabBarItem.image = [UIImage imageNamed:@"53-house"];
    
    tabBar.viewControllers = @[ViewNav,newViewNav,SpecialViewNav,MainViewNav];
    tabBar.delegate = self;
    tabBar.tabBar.tintColor = [UIColor orangeColor];
    tabBar.tabBar.barTintColor = [UIColor redColor];
    self.window.rootViewController = tabBar;
    self.window.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:235/255.0];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    
    
    

    
    
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
