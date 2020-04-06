//
//  WTRWelcomeViewController.m
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "WTRWelcomeViewController.h"

//typedef void (^OnButtonGetStartedDidTap)(void);

@interface WTRWelcomeViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (copy, nonatomic) void (^completionBlock)(void);
@end


@implementation WTRWelcomeViewController

- (instancetype)initWithCompletion:(void (^)(void))completion {
    self = [super initWithNibName:@"WTRWelcomeViewController" bundle:nil];
    if (self) {
        _completionBlock = completion;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTitles];
//    [self setupNavigationBar];
}

- (void)setupTitles {
    self.title = @"WeatherCity💦";
}

- (void)setupNavigationBar {
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = add;
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    self.navigationItem.leftBarButtonItem = edit;
}

- (void)add {
    NSLog(@"Add did tap");
}

- (void)edit {
    NSLog(@"Edit did tap");
}

- (IBAction)buttonGetStartedDidTap:(UIButton *)sender {
    self.completionBlock();
    
    
    
//    self.contentView.hidden = YES;
//    UIViewController *searchViewController = [[UIViewController alloc] init];
//    searchViewController.view.backgroundColor = UIColor.redColor;
//    [self.navigationController presentViewController:searchViewController animated:YES completion:^{
//
//    }];
    
}



@end
