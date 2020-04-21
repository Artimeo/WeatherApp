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
@property (nonatomic, strong, readwrite) UINavigationController *navigationController;
@property (nonatomic, strong) WTRWelcomeViewController *welcomeViewController;
@property (nonatomic, strong) WTRSearchTableViewController *searchViewController;
@end

@implementation AppCoordinator

- (instancetype)init {
    self = [super init];
    if (self){
        __weak AppCoordinator *welf = self;
        [self startWithCompletion:^{
            welf.navigationController = [[UINavigationController alloc] initWithRootViewController:welf.welcomeViewController];
        }];
    }
    return self;
}

- (instancetype)initWithNavigationController:(UINavigationController *)nvc {
    self = [super init];
    if (self) {
        _navigationController = nvc;
    }
    return self;
}

- (void)startWithCompletion:(void (^)(void))completion {
    [self showWelcomeScreen];
    completion();
}

- (void)showWelcomeScreen {
    if (!self.welcomeViewController) {
        __weak AppCoordinator *welf = self;
        self.welcomeViewController = [[WTRWelcomeViewController alloc] initWithCompletion:^{
            [welf showSearchViewController];
        }];
        [self.navigationController addChildViewController:self.welcomeViewController];
    }
}

- (void)showSearchViewController {
    //__weak AppCoordinator *welf = self;
    self.searchViewController = [[WTRSearchTableViewController alloc] initWithCompletion:^{
        
    }];
    [self.navigationController presentViewController:self.searchViewController animated:YES completion:nil];
}

@end
