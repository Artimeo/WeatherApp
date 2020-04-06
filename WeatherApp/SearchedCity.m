//
//  SearchedCity.m
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "SearchedCity.h"

@interface SearchedCity()
@property (nonatomic, strong, readwrite) NSString *city;
@property (nonatomic, strong, readwrite) NSString *country;
@property (nonatomic, readwrite, strong) NSURL *previewURL;
@property (nonatomic, readwrite, assign) int index;
@end

@implementation SearchedCity

- (instancetype)initWithCity:(NSString *)city country:(NSString *)country previewURL:(NSURL *)previewURL index:(int)index{
    self = [super init];
    if (self) {
        _city = city;
        _country = country;
        _previewURL = previewURL;
        _index = index;
    }
    return self;
}

@end
