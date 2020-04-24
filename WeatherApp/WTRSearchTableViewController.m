//
//  WTRSearchTableViewController.m
//  WeatherApp
//
//  Created by Artem Buryakov on 05.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "WTRSearchTableViewController.h"
#import "SearchedCityTableViewCell.h"
#import "CitiesModel.h"
#import "CityItem.h"

static NSString *kCellIdentifier = @"searchedCityCell";

@interface WTRSearchTableViewController () <UISearchBarDelegate>
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) CitiesModel *model;
@end

@implementation WTRSearchTableViewController

- (instancetype)initWithCompletion:(void (^)(void))completion {
    self = [super initWithNibName:@"WTRSearchTableViewController" bundle:nil];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerCell];
    [self setupSearchController];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.searchController setActive:YES];
    [self.searchController.searchBar becomeFirstResponder];
}

- (CitiesModel *)model {
    if (!_model) {
        _model = [[CitiesModel alloc] init];
    }
    return _model;
}

- (void)registerCell {
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchedCityTableViewCell" bundle:nil] forCellReuseIdentifier:kCellIdentifier];
}

- (void)setupSearchController {
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.placeholder = @"Search Cities";
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
}

- (void)addRefreshControl {
    self.tableView.refreshControl = [UIRefreshControl new];
    self.tableView.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Loading..."];
    [self.tableView.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
}


#pragma mark - UITableViewDataSource

- (void)configureCell:(SearchedCityTableViewCell *)cell withCity:(CityItem *) city{
    cell.city.text = city.name;
    cell.country.text = city.country;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.model.count;
}

- (SearchedCityTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchedCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        [self configureCell:cell withCity:[self.model cityAtIndex:indexPath.row]];
    }
    return cell;
}
         
 -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     return  UITableViewAutomaticDimension;
 }


#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *searchQuery = self.searchController.searchBar.text;
    
    __weak WTRSearchTableViewController *welf = self;
    [self.model loadCitiesWithQuery:searchQuery completion:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [welf.tableView reloadData];
        });
    } error:^(NSString *errorMessage){
        [welf showAlertWithMessage:errorMessage];
    }];
}


#pragma mark - Alert & etc.

- (void)showAlertWithMessage:(NSString *)errorMessage {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:errorMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
       handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
