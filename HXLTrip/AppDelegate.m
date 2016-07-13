//
//  AppDelegate.m
//  HXLTrip
//
//  Created by Carrot on 16/7/13.
//  Copyright © 2016年 Carrot. All rights reserved.
//

#import "AppDelegate.h"
#import "HXLStoryBoardLoader.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self setupToolBar];
    [self.window makeKeyAndVisible];
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

- (void)setupToolBar{
    UITabBarController* tbvc = [UITabBarController new];
    
    UIViewController* vc1 = [UIViewController new];
    UIViewController* homepage = HXLShortcutViewController(@"HXLHomePageViewController",@"Main", nil);
    vc1 = homepage;
    vc1.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"vc1" image:nil selectedImage:nil];
    vc1.view.backgroundColor = [UIColor redColor];
    
    UIViewController* vc2 = [UIViewController new];
    vc2.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"vc2" image:nil selectedImage:nil];
    vc2.view.backgroundColor = [UIColor greenColor];
    
    UIViewController* vc3 = [UIViewController new];
    vc3.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"vc3" image:nil selectedImage:nil];
    vc3.view.backgroundColor = [UIColor yellowColor];
    
    UIViewController* vc4 = [UIViewController new];
    vc4.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"vc4" image:nil selectedImage:nil];
    vc4.view.backgroundColor = [UIColor blueColor];
    
    tbvc.viewControllers = @[vc1, vc2, vc3,vc4];
    tbvc.selectedIndex = 0;
    
    self.window.rootViewController = tbvc;
}

@end
