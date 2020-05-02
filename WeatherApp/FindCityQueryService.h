//
//  CitiesLoader.h
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityItem;

typedef void (^QueryResult) (NSArray <CityItem *> *);

@interface FindCityQueryService : NSObject

@property (nonatomic, copy, readonly) NSString *errorMessage;
- (void)loadCitiesWithQuery:(NSString *)qCity completion:(QueryResult)completion;

@end
