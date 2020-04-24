//
//  CitiesModel.m
//  WeatherApp
//
//  Created by Artem Buryakov on 09.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "CitiesModel.h"
#import "FindCityQueryService.h"

@interface CitiesModel()
@property (nonatomic, strong) FindCityQueryService *queryService;
@end

@implementation CitiesModel

- (void)loadCitiesWithQuery:(NSString *)searchQuery completion:(VoidBlock)onCompletion error:(ErrorBlock)onError {
    __weak CitiesModel *welf = self;
    [self.queryService getSearchResultsWithQuery:searchQuery completion:^(NSArray<CityItem *> *cities, NSString *error) {
        welf.cities = cities;
        if (error) {
            onError(error);
        } else {
            onCompletion();
        }
    }];
}

- (CityItem *)cityAtIndex:(NSInteger)index {
    return [self.cities objectAtIndex:index];
};

- (NSUInteger)count {
    return self.cities.count;
};

- (FindCityQueryService *)queryService {
    if (!_queryService) {
        _queryService = [[FindCityQueryService alloc] init];
    }
    return _queryService;
}

@end
