//
//  CityItem.m
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "CityItem.h"

@interface CityItem()
@property (nonatomic, readwrite, strong) NSString *cityID;
@property (nonatomic, readwrite, strong) NSString *name;
@property (nonatomic, readwrite, strong) NSString *country;
@property (nonatomic, readwrite, assign) CLLocationCoordinate2D coordinates;
@property (nonatomic, readwrite, strong) NSDate *requestDate;

// weather
@property (nonatomic, readwrite, assign) NSInteger weatherID;
@property (nonatomic, readwrite, strong) NSString *weatherState;
@property (nonatomic, readwrite, strong) NSString *weatherDescription;
@property (nonatomic, readwrite, strong) NSString *weatherIconCode;

// main
@property (nonatomic, readwrite, assign) CGFloat temp;
@property (nonatomic, readwrite, assign) CGFloat feelsLike;
@property (nonatomic, readwrite, assign) CGFloat tempMin;
@property (nonatomic, readwrite, assign) CGFloat tempMax;
@property (nonatomic, readwrite, assign) NSInteger pressure; // hPa
@property (nonatomic, readwrite, assign) NSInteger humidity; // %

// wind
@property (nonatomic, readwrite, assign) NSInteger windSpeed; // meters/sec
@property (nonatomic, readwrite, assign) NSInteger windDegrees;

// clouds.all
@property (nonatomic, readwrite, assign) NSInteger cloudness; // %

// rain
@property (nonatomic, readwrite, assign) NSInteger rain1h;
@property (nonatomic, readwrite, assign) NSInteger rain3h;

// snow
@property (nonatomic, readwrite, assign) NSInteger snow1h;
@property (nonatomic, readwrite, assign) NSInteger snow3h;

@property (nonatomic, readwrite, strong) NSDate *sunrise;
@property (nonatomic, readwrite, strong) NSDate *sunset;
@property (nonatomic, readwrite, strong) NSTimeZone *timeZone;
@end

@implementation CityItem

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)dict {
    self = [super init];
    if (self) {
        _cityID = dict[@"id"];
        _name = dict[@"name"];
        
        NSDictionary *coord = dict[@"coord"];
        if ([coord isKindOfClass:[NSDictionary class]]) {
            CLLocationDegrees latitude = [coord[@"lat"] doubleValue];
            CLLocationDegrees longitude = [coord[@"lon"] doubleValue];
            _coordinates = CLLocationCoordinate2DMake(latitude, longitude);
        }
        NSDictionary *weather = dict[@"weather"];
        if ([weather isKindOfClass:[NSDictionary class]]) {
            _weatherID = [weather[@"id"] integerValue];
            _weatherState = weather[@"main"];
            _weatherDescription = weather[@"description"];
            _weatherIconCode = weather[@"icon"];
        }
        NSDictionary *main = dict[@"main"];
        if ([main isKindOfClass:[NSDictionary class]]) {
            _temp = [main[@"temp"] doubleValue];
            _feelsLike = [main[@"feels_like"] doubleValue];
            _tempMin = [main[@"temp_min"] doubleValue];
            _tempMax = [main[@"temp_max"] doubleValue];
            _pressure = [main[@"pressure"] doubleValue];
            _humidity = [main[@"humidity"] doubleValue];
        }
        NSDictionary *wind = dict[@"wind"];
        if ([wind isKindOfClass:[NSDictionary class]]) {
            _windSpeed = [wind[@"speed"] integerValue];
            _windDegrees = [wind[@"deg"] integerValue];
        }
        NSDictionary *clouds = dict[@"clouds"];
        if ([clouds isKindOfClass:[NSDictionary class]]) {
            _cloudness = [clouds[@"all"] integerValue];
        }
        NSDictionary *rain = dict[@"rain"];
        if ([rain isKindOfClass:[NSDictionary class]]) {
            _rain1h = [rain[@"1h"] integerValue];
            _rain3h = [rain[@"3h"] integerValue];
        }
        NSDictionary *snow = dict[@"snow"];
        if ([snow isKindOfClass:[NSDictionary class]]) {
            _snow1h = [snow[@"1h"] integerValue];
            _snow3h = [snow[@"3h"] integerValue];
        }
        if ([dict[@"dt"] isKindOfClass:[NSString class]]) {
            NSTimeInterval dt = [dict[@"dt"] doubleValue];
            _requestDate = [self NSDateFromUTC:dt];
        }
        NSDictionary *sys = dict[@"sys"];
        if ([sys isKindOfClass:[NSDictionary class]]) {
            _country = sys[@"country"];
            NSTimeInterval sunrise = [sys[@"sunrise"] doubleValue];
            _sunrise = [self NSDateFromUTC:sunrise];
            NSTimeInterval sunset = [sys[@"sunset"] doubleValue];
            _sunset = [self NSDateFromUTC:sunset];
        }
    }
    return self;
}

- (NSDate *)NSDateFromUTC:(NSTimeInterval)UTC {
    return [[NSDate alloc] initWithTimeIntervalSince1970:UTC];
}

- (instancetype)initWithCityID:(NSString *)cityID name:(NSString *)name country:(NSString *)country {
    self = [super init];
    if (self) {
        _cityID = cityID;
        _name = name;
        _country = country;
    }
    return self;
}

@end
