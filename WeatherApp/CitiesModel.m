//
//  CitiesModel.m
//  WeatherApp
//
//  Created by Artem Buryakov on 09.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "CitiesModel.h"

@interface CitiesModel()
@property (nonatomic, strong, readwrite) NSMutableArray<CityItem *> *cities;
@end

@implementation CitiesModel

- (void)updateWithCities:(NSArray<CityItem *> *)cities {
    self.cities = [[NSMutableArray alloc] initWithArray:cities];
}

- (void)updateWithCity:(CityItem *)city {
    [self.cities addObject:city];
}

- (CityItem *)cityAtIndex:(NSInteger)index {
    return [self.cities objectAtIndex:index];
};

- (NSUInteger)count {
    return self.cities.count;
};

- (NSMutableArray<CityItem *> *)cities {
    if (!_cities) {
        _cities = [[NSMutableArray alloc] init];
    }
    return _cities;
}

@end
