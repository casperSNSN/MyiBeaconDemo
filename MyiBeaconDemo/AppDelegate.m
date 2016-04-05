//
//  AppDelegate.m
//  MyiBeaconDemo
//
//  Created by 孙宁 on 15/4/1.
//  Copyright (c) 2015年 cnlive. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BRTBeaconSDK.h"

#define BRT_SDK_KEY @"60b056a30d1f4c98aa158cc91469ad7b"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    ViewController *view=[[ViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:view];
    self.window.rootViewController=nav;
    [BRTBeaconSDK registerApp:BRT_SDK_KEY onCompletion:^(NSError *error) {
        
    }];
    [self.window makeKeyAndVisible];
    
    // Override point for customization after application launch.
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
#pragma mark --监测
//监听失败回调
-(void)beaconManager:(BRTBeaconManager *)manager monitoringDidFailForRegion:(BRTBeaconRegion *)region withError:(NSError *)error{
    NSLog(@"%@",error);
}
//进入区域回调
-(void)beaconManager:(BRTBeaconManager *)manager didEnterRegion:(BRTBeaconRegion *)region{
    if(region.notifyOnEntry){
        //to do
        UIAlertView *view=[[UIAlertView alloc] initWithTitle:@"您好" message:@"您已经进入监控区域" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
    }
}
//离开区域回调
-(void)beaconManager:(BRTBeaconManager *)manager didExitRegion:(BRTBeaconRegion *)region{
    if(region.notifyOnExit){
        //to do
        UIAlertView *view=[[UIAlertView alloc] initWithTitle:@"您好" message:@"您已经离开监控区域" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [view show];
    }
}
//屏幕点亮区域检测、requestStateForRegions回调
-(void)beaconManager:(BRTBeaconManager *)manager didDetermineState:(CLRegionState)state forRegion:(BRTBeaconRegion *)region{
    if(region.notifyEntryStateOnDisplay){
        //to do
    }else if(region.notifyOnEntry){
        //to do
    }else if(region.notifyOnExit){
        //to do
    }
}


@end
