//
//  AppDelegate.m
//  WeatherApp
//
//  Created by Artem Buryakov on 04/04/2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "AppDelegate.h"
#import "AppCoordinator.h"

@interface AppDelegate ()
@property (nonatomic, strong) AppCoordinator *appCoordinator;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    self.appCoordinator = [[AppCoordinator alloc] init];
    
    self.window.rootViewController = self.appCoordinator.navigationController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
