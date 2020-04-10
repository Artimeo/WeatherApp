//
//  CitiesModel.m
//  WeatherApp
//
//  Created by Artem Buryakov on 09.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "CitiesModel.h"

@implementation CitiesModel

- (CityEntity *)cityAtIndex:(NSInteger)index {
    return [self.cities objectAtIndex:index];
};

- (NSUInteger)citiesCount {
    return self.cities.count;
};

@end
