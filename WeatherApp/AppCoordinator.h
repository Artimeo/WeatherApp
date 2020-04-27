//
//  AppCoordinator.h
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AppCoordinator : NSObject

@property (nonatomic, strong, readonly) UINavigationController *navigationController;
- (void)showSearchViewController;
- (void)showCitiesScrollView;
- (void)presentRootController;

@end

