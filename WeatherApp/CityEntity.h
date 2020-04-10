//
//  SearchedCity.h
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <CoreLocation/CoreLocation.h>

@interface CityEntity : NSObject
@property (nonatomic, readonly, strong) NSString *cityID;
@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *country;
@property (nonatomic, readonly, assign) CLLocationCoordinate2D coordinates;
@property (nonatomic, readonly, strong) NSDate *requestDate;

// weather
@property (nonatomic, readonly, assign) NSInteger weatherID;
@property (nonatomic, readonly, strong) NSString *weatherState;
@property (nonatomic, readonly, strong) NSString *weatherDescription;
@property (nonatomic, readonly, strong) NSString *weatherIconCode;

// main
@property (nonatomic, readonly, assign) CGFloat temp;
@property (nonatomic, readonly, assign) CGFloat feelsLike;
@property (nonatomic, readonly, assign) CGFloat tempMin;
@property (nonatomic, readonly, assign) CGFloat tempMax;
@property (nonatomic, readonly, assign) NSInteger pressure; // hPa
@property (nonatomic, readonly, assign) NSInteger humidity; // %

// wind
@property (nonatomic, readonly, assign) NSInteger windSpeed; // meters/sec
@property (nonatomic, readonly, assign) NSInteger windDegrees;

// clouds.all
@property (nonatomic, readonly, assign) NSInteger cloudness; // %

// rain
@property (nonatomic, readonly, assign) NSInteger rain1h;
@property (nonatomic, readonly, assign) NSInteger rain3h;

// snow
@property (nonatomic, readonly, assign) NSInteger snow1h;
@property (nonatomic, readonly, assign) NSInteger snow3h;

@property (nonatomic, readonly, strong) NSDate *sunrise;
@property (nonatomic, readonly, strong) NSDate *sunset;
@property (nonatomic, readonly, strong) NSTimeZone *timeZone;

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dict;
- (instancetype)initWithCityID:(NSString *)cityID name:(NSString *)name country:(NSString *)country;
@end
