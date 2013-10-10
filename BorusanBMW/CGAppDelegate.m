//
//  CGAppDelegate.m
//  BorusanBMW
//
//  Created by Baris YILMAZ on 9/3/13.
//  Copyright (c) 2013 Baris YILMAZ. All rights reserved.
//

#import "CGAppDelegate.h"

#import "CGMainViewController.h"
#import "Server.h"
#import "LocationManager.h"
#import <RestKit/RestKit.h>

@implementation CGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    //self.viewController = [[CGViewController alloc] initWithNibName:@"CGViewController" bundle:nil];
    CGFloat screenWidth  = [[UIScreen mainScreen] bounds].size.width * [[UIScreen mainScreen] scale];
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height * [[UIScreen mainScreen] scale];
    
    // See device screen resolution according to scale value to get real size.
    NSLog(@"Device width: %f", screenWidth);
    NSLog(@"Device height: %f", screenHeight);
    NSLog(@"Device scale: %f", [[UIScreen mainScreen] scale]);
    
    CGMainViewController *mainViewController = [[CGMainViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    
    UIImage *navbarBg = [UIImage imageNamed:@"ContentHeader.png"];
	
    if ([navController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
	{
		[navController.navigationBar setBackgroundImage:navbarBg
                                          forBarMetrics:UIBarMetricsDefault];
	}
	else {
		[navController.navigationBar insertSubview:[[UIImageView alloc] initWithImage:navbarBg] atIndex:0];
    }

    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    
    [LocationManager shared];
    // Server
    [Server shared];
    
    // Log all HTTP traffic with request and response bodies
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
    
    // Log debugging info about Core Data
    RKLogConfigureByName("RestKit/CoreData", RKLogLevelDebug);

    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
