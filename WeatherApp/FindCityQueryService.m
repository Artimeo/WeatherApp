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
const NSString *qAPPID = @"6d8e495ca73d5bbc1d6bf8ebd52c4";
const NSString *qType = @"like";
const NSString *qUnits = @"metric";
const NSString *qLang = @"ru";

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
    urlComponents.query = [NSString stringWithFormat:@"?q=%@&type=%@&units=%@&lang=%@&APPID=%@", qCity, qType, qUnits, qLang, qAPPID];
    
    NSURL *url = urlComponents.URL;
    if (!url) {
        return;
    }
    
    __weak FindCityQueryService *welf = self;
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            welf.errorMessage = [self.errorMessage stringByAppendingFormat:@"DataTask error: %@\n", error.localizedDescription];
            welf.dataTask = nil;
            completion(self.cities, self.errorMessage);
            return;
        }
        
        if (data == nil) {
            completion(self.cities, self.errorMessage);
            welf.dataTask = nil;
            return;
        }
    
        NSHTTPURLResponse *resp = (NSHTTPURLResponse *)response;
        if (resp != nil && resp.statusCode == 200) {
            welf.dataTask = nil;
            [welf updateSearchResultsWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(self.cities, self.errorMessage);
            });
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
    
    NSString *statusCode = response[@"cod"];
    if (![statusCode isEqualToString:@"200"]) {
        self.errorMessage = [self.errorMessage stringByAppendingFormat:@"Server returned status code %@\n", statusCode];
        return;
    }
    
    NSArray *cities = response[@"list"];
    if (!cities) {
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

@end
