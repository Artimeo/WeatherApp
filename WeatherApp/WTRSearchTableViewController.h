//
//  WTRSearchTableViewController.h
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCoordinator.h"
#import "CitiesModel.h"

@interface WTRSearchTableViewController : UITableViewController

- (instancetype)initWithCoordinator:(AppCoordinator *)coordinator Model:(CitiesModel *)model;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

@end
