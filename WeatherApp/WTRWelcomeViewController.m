//
//  WTRWelcomeViewController.m
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "WTRWelcomeViewController.h"

@interface WTRWelcomeViewController ()
@property (nonatomic, weak) AppCoordinator *coordinator;
@property (nonatomic, weak) IBOutlet UIButton *chooseCityButton;
@property (nonatomic, copy) void (^completionBlock)(void);
@end


@implementation WTRWelcomeViewController

- (instancetype)initWithCoordinator:(AppCoordinator *)coordinator {
    self = [super initWithNibName:@"WTRWelcomeViewController" bundle:nil];
    if (self) {
        _coordinator = coordinator;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chooseCityButton.layer.cornerRadius = 3;
}

- (IBAction)buttonChooseCityDidTap:(UIButton *)sender {
    [self.coordinator showSearchViewController];
}



@end
