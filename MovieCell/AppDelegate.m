//
//  AppDelegate.m
//  MovieCell
//
//  Created by chanyezhenghe on 16/4/21.
//  Copyright © 2016年 chanyezhenghe. All rights reserved.
//

#import "AppDelegate.h"
#import "GDtabbarCtr.h"


@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _window.backgroundColor = [UIColor whiteColor];
    
    [self setRoot];
    
    [_window makeKeyAndVisible];
    
    return YES;
}

- (void)setRoot{
    
    GDtabbarCtr * tab = [[GDtabbarCtr alloc] init];
    
    [tab addviewCtrlString:@"GDHomeViewController" andTitle:@"中" selectImage:@"tab_cookbook_hl" image:@"tab_cookbook"];
    [tab addviewCtrlString:@"GDListViewController" andTitle:@"午" selectImage:@"tab_plaza_hl" image:@"tab_plaza"];
    [tab addviewCtrlString:@"GDShopViewController" andTitle:@"吃" selectImage:@"tab_explore_hl" image:@"tab_explore"];
    [tab addviewCtrlString:@"GDSettingViewController" andTitle:@"啥" selectImage:@"tab_aboutme_hl" image:@"tab_aboutme"];
    
    
    self.window.rootViewController = tab;
    
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
