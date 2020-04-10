//
//  CitiesLoader.h
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityEntity;

typedef void (^QueryResult) (NSArray <CityEntity *> *, NSString *error);

@interface FindCityQueryService : NSObject
- (void)getSearchResultsWithQuery:(NSString *)qCity completion:(QueryResult)completion;
@end
