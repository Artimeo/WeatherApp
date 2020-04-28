//
//  AppCoordinator.m
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "WTRWelcomeViewController.h"
#import "WTRSearchTableViewController.h"
#import "WTRRootViewController.h"
#import "WTRWeatherViewController.h"

@interface AppCoordinator()
@property (nonatomic, strong, readwrite) UINavigationController *navigationController;
@property (nonatomic, strong) WTRRootViewController             *rootViewController;
@property (nonatomic, strong) WTRWelcomeViewController          *welcomeViewController;
@property (nonatomic, strong) WTRSearchTableViewController      *searchViewController;
@property (nonatomic, strong) WTRWeatherViewController          *weatherViewController;
@end

@implementation AppCoordinator

- (instancetype)init {
    self = [super init];
    if (self){
        [self start];
    }
    return self;
}

- (void)start {
    self.rootViewController = [[WTRRootViewController alloc] initWithCoordinator:self];
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:self.rootViewController];
    [self presentRootController];
}

- (void)presentRootController {
    if (self.navigationController.presentedViewController == self.searchViewController) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (self.rootViewController.model.count == 0) {
        [self showWelcomeScreen];
    }
    else {
        [self showCitiesScrollView];
    }
}

- (void)showWelcomeScreen {
    [self removeSubviewsFromRootViewController];
    self.welcomeViewController = [[WTRWelcomeViewController alloc] initWithCoordinator:self];
    [self.rootViewController.view addSubview:self.welcomeViewController.view];
}

- (void)showSearchViewController {
    self.searchViewController = [[WTRSearchTableViewController alloc] initWithCoordinator:self Model:self.rootViewController.model];
    [self.navigationController presentViewController:self.searchViewController animated:YES completion:nil];
}

- (void)showCitiesScrollView {
    NSLog(@"there are %lu cities in model", self.rootViewController.model.count);
    [self removeSubviewsFromRootViewController];
    self.weatherViewController = [[WTRWeatherViewController alloc] initWithCoordinator:self Model:self.rootViewController.model];
    [self.rootViewController.view addSubview:self.weatherViewController.view];
}

- (void)removeSubviewsFromRootViewController {
    NSArray *viewsToRemove = [self.rootViewController.view subviews];
    for (UIView *v in viewsToRemove) {
        [v removeFromSuperview];
    }
}

@end
