//
//  CitiesLoader.h
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityItem;

typedef void (^QueryResult) (NSArray <CityItem *> *, NSString *error);

@interface FindCityQueryService : NSObject
- (void)getSearchResultsWithQuery:(NSString *)qCity completion:(QueryResult)completion;
@end
