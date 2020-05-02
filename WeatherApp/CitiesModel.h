//
//  CitiesModel.h
//  WeatherApp
//
//  Created by Artem Buryakov on 09.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityItem;

@interface CitiesModel : NSObject
@property (nonatomic, strong, readonly) NSMutableArray<CityItem *> *cities;

- (void)updateWithCities:(NSArray <CityItem *> *)cities;
- (void)updateWithCity:(CityItem *)city;

- (CityItem *)cityAtIndex:(NSInteger)index;
- (NSUInteger)count;
@end
