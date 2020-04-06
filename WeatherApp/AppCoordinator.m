//
//  AppCoordinator.m
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "AppCoordinator.h"
#import "WTRWelcomeViewController.h"
#import "WTRSearchTableViewController.h"

@interface AppCoordinator()
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) WTRWelcomeViewController *welcomeViewController;
@property (nonatomic, strong) WTRSearchTableViewController *searchViewController;
@end

@implementation AppCoordinator

- (instancetype)initWithNavigationController:(UINavigationController *)nvc {
    self = [super init];
    if (self) {
        _navigationController = nvc;
    }
    return self;
}

- (void)start {
    [self showWelcomeScreen];
}

- (void)showWelcomeScreen {
    if (!self.welcomeViewController) {
        self.welcomeViewController = [[WTRWelcomeViewController alloc] initWithCompletion:^{
            [self showSearchViewController];
        }];
        [self.navigationController addChildViewController:self.welcomeViewController];
    }
}

- (void)showSearchViewController {
    self.searchViewController = [[WTRSearchTableViewController alloc] initWithCompletion:^{
        
    }];
    [self.navigationController presentViewController:self.searchViewController animated:YES completion:nil];
}

@end
