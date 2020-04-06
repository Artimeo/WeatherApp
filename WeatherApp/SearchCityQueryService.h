//
//  CitiesLoader.h
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SearchedCity;

typedef void (^QueryResult) (NSArray <SearchedCity *> *, NSString *error);

@interface SearchCityQueryService : NSObject
- (void)getSearchResultsWithQuery:(NSString *)query completion:(QueryResult)completion;
@end
