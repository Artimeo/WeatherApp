//
//  AppCoordinator.h
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WTRWelcomeViewController.h"
#import "WTRSearchTableViewController.h"


@interface AppCoordinator : NSObject

- (instancetype)initWithNavigationController:(UINavigationController *)nvc;
- (void)start;

@end

