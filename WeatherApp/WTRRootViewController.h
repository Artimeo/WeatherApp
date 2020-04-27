//
//  WTRRootViewController.h
//  
//
//  Created by Artem Buryakov on 27.04.2020.
//

#import <UIKit/UIKit.h>
#import "AppCoordinator.h"
#import "CitiesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WTRRootViewController : UIViewController

@property (nonatomic, strong, readonly) CitiesModel *model;

- (instancetype)initWithCoordinator:(AppCoordinator *)coordinator;

@end

NS_ASSUME_NONNULL_END
