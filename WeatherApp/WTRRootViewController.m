//
//  WTRRootViewController.m
//  
//
//  Created by Artem Buryakov on 27.04.2020.
//

#import "WTRRootViewController.h"

@interface WTRRootViewController()
@property (nonatomic, weak) AppCoordinator *coordinator;
@property (nonatomic, strong, readwrite) CitiesModel *model;
@end

@implementation WTRRootViewController

-(instancetype)initWithCoordinator:(AppCoordinator *)coordinator {
    self = [super init];
    if (self) {
        _model = [[CitiesModel alloc] init];
        _coordinator = coordinator;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"WeatherApp";
    [self setupNavigationBar];
}

- (void)setupNavigationBar {
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(add)];
    self.navigationItem.rightBarButtonItem = add;
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(edit)];
    self.navigationItem.leftBarButtonItem = edit;
}

- (void)add {
    [self.coordinator showSearchViewController];
}

- (void)edit {
    NSLog(@"Edit did tap");
}

@end
