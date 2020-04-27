//
//  CitiesLoader.m
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "FindCityQueryService.h"
#import "CityItem.h"

typedef NSDictionary <NSString *, id> * JSONDictionary;
const NSString *qAPPID = @"b25c1900a4b79a996e0bb44831c80b20";
const NSString *qType = @"like";
const NSString *qUnits = @"metric";
const NSString *qLang = @"en";

@interface FindCityQueryService()
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, strong) NSMutableArray <CityItem *> *cities;
@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end


@implementation FindCityQueryService

- (void)getSearchResultsWithQuery:(NSString *)qCity completion:(QueryResult)completion {
    [self.dataTask cancel];

    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:@"http://api.openweathermap.org/data/2.5/find"];
    urlComponents.query = [NSString stringWithFormat:@"q=%@&type=%@&units=%@&lang=%@&APPID=%@", qCity, qType, qUnits, qLang, qAPPID];
    
    NSURL *url = urlComponents.URL;
    if (!url) {
        return;
    }
    
    __weak FindCityQueryService *welf = self;
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            welf.errorMessage = [welf.errorMessage stringByAppendingFormat:@"DataTask error: %@\n", error.localizedDescription];
            [welf.dataTask cancel];
            welf.dataTask = nil;
            completion(welf.cities, welf.errorMessage);
            return;
        }
    
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if (httpResponse) {
            [welf.dataTask cancel];
            welf.dataTask = nil;
            [welf updateSearchResultsWithData:data];
            completion(welf.cities, welf.errorMessage);
        }
    }];
    
    [self.dataTask resume];
}

#pragma mark - Private

- (void)updateSearchResultsWithData:(NSData *)data {
    JSONDictionary response = @{};
    self.cities = [NSMutableArray new];
    NSError *error = nil;
    @try {
        response = (JSONDictionary)[NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    } @catch (NSError *parseError) {
        self.errorMessage = [self.errorMessage stringByAppendingFormat:@"JSONSerialization error: %@\n", parseError.localizedDescription];
        return;
    } @finally { }
    
    if (!response) {
        self.errorMessage = [self.errorMessage stringByAppendingString:@"Empty Data\n"];
        return;
    }
    
    NSString *statusCode = response[@"cod"];
    if (![statusCode isEqualToString:@"200"]) {
        self.errorMessage = [self.errorMessage stringByAppendingFormat:@"Server returned status code %@\n", statusCode];
        return;
    }
    
    NSArray *cities = response[@"list"];
    if (!cities || cities.count == 0) {
        self.errorMessage = [self.errorMessage stringByAppendingString:@"Dictionary does not contain results key\n"];
        return;
    }
    
    for (NSDictionary *city in cities) {
        CityItem *foundCity = [[CityItem alloc] initWithDictionary:city];
        [self.cities addObject:foundCity];
    }
}

- (NSURLSession *)defaultSession {
    if (!_defaultSession) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _defaultSession = [NSURLSession sessionWithConfiguration:config];
    }
    return _defaultSession;
}

- (NSString *)errorMessage {
    if (!_errorMessage) {
        _errorMessage = @"";
    }
    return _errorMessage;
}

@end
