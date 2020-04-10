//
//  CitiesModel.h
//  WeatherApp
//
//  Created by Artem Buryakov on 09.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CityEntity;

@interface CitiesModel : NSObject
@property (nonatomic, strong) NSArray<CityEntity *> *cities;

- (CityEntity *)cityAtIndex:(NSInteger)index;
- (NSUInteger)citiesCount;
@end
