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
    UINavigationController *navigationController = [[UINavigationController alloc] init];
    self.appCoordinator = [[AppCoordinator alloc] initWithNavigationController:navigationController];
    self.window.rootViewController = navigationController;

    [self.appCoordinator start];
    return YES;
}

@end
