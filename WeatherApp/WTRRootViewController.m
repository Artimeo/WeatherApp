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
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
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
    [self setupPageControl];
}
- (void)viewDidAppear:(BOOL)animated {
    if (self.model.count > 0) {
        [self.pageControl setNumberOfPages:self.model.count];
    }
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}

- (void) setupPageControl {
    [self.view addSubview:self.pageControl];
    self.pageControl.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pageControl.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:40].active = YES;
    [self.pageControl.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    self.pageControl.backgroundColor = UIColor.blackColor;
}

- (void)setupScrollView {
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * self.model.count, self.view.frame.size.height);
    [self.scrollView setPagingEnabled:YES];
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
