//
//  WTRWelcomeViewController.h
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCoordinator.h"

@interface WTRWelcomeViewController : UIViewController
- (instancetype)initWithCoordinator:(AppCoordinator *)coordinator;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
@end
