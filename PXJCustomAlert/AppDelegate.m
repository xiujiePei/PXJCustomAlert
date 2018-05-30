//
//  AppDelegate.m
//  PXJCustomAlert
//
//  Created by 裴秀杰 on 2018/5/25.
//  Copyright © 2018年 JackP. All rights reserved.
//

#import "AppDelegate.h"
#import "PXJCustomAlert.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
//    //1.0
//    PXJCustomAlert *alert = [PXJCustomAlert alertWithTile:@"" withMessage:@"您的登录身份已过期，请重新登录"];
//    PXJCAlertAction *btn = [PXJCAlertAction alertActionWithTitle:@"取消" withBlock:^{
//        NSLog(@"取消");
//    }];
//    [alert addAlertAction:btn];
//    [alert showAlert];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
