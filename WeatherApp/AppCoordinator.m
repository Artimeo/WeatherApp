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

@interface AppCoordinator()
@property (nonatomic, strong, readwrite) UINavigationController *navigationController;
@property (nonatomic, strong) WTRRootViewController             *rootViewController;
@property (nonatomic, strong) WTRWelcomeViewController          *welcomeViewController;
@property (nonatomic, strong) WTRSearchTableViewController      *searchViewController;
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
    if (self.rootViewController.model.count == 0) {
        [self showWelcomeScreen];
    }
    else {
        [self showCitiesScrollView];
    }
}

- (void)showWelcomeScreen {
    self.welcomeViewController = [[WTRWelcomeViewController alloc] initWithCoordinator:self];
    [self.rootViewController.view addSubview:self.welcomeViewController.view];
}

- (void)showSearchViewController {
    __weak AppCoordinator *welf = self;
    self.searchViewController = [[WTRSearchTableViewController alloc] initWithCompletion:^{
        [welf.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.navigationController presentViewController:self.searchViewController animated:YES completion:nil];
}

- (void)showCitiesScrollView {
    
}

@end
