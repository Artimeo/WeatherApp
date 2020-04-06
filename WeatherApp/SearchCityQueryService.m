//
//  CitiesLoader.m
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "SearchCityQueryService.h"
#import "SearchedCity.h"

typedef NSDictionary <NSString *, id> * JSONDictionary;
const NSString *qAPPID = @"6d8e495ca73d5bbc1d6bf8ebd52c4";
const NSString *qType = @"like";
const NSString *qUnits = @"metric";

@interface SearchCityQueryService()
@property (nonatomic, copy) NSString *errorMessage;
@property (nonatomic, strong) NSMutableArray <SearchedCity *> *cities;
@property (nonatomic, strong) NSURLSession *defaultSession;
@property (nonatomic, strong) NSURLSessionDataTask *dataTask;
@end


@implementation SearchCityQueryService

- (void)getSearchResultsWithQuery:(NSString *)query completion:(QueryResult)completion {
    [self.dataTask cancel];

    NSURLComponents *urlComponents = [NSURLComponents componentsWithString:@"http://api.openweathermap.org/data/2.5/find"];
    urlComponents.query = [NSString stringWithFormat:@"?q=%@&type=%@&units=%@APPID=%@", query, qType, qUnits, qAPPID];
    
    NSURL *url = urlComponents.URL;
    if (!url) {
        return;
    }
    
    __weak SearchCityQueryService *welf = self;
    self.dataTask = [self.defaultSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            welf.errorMessage = [self.errorMessage stringByAppendingString:@"DataTask error: \(error.localizedDescription)\n"];
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
        self.errorMessage = [self.errorMessage stringByAppendingString:@"JSONSerialization error: \(parseError.localizedDescription)\n"];
        return;
    } @finally { }
    
    NSArray *array = response[@"results"];
    if (!array) {
        self.errorMessage = [self.errorMessage stringByAppendingString:@"Dictionary does not contain results key\n"];
    }
    
    int index = 0;
    
    for (NSDictionary *trackDictionary in array) {
        NSString *previewURLString = trackDictionary[@"previewUrl"];
        NSURL *previewURL = [NSURL URLWithString:previewURLString];
        NSString *city = trackDictionary[@"city"];
        NSString *country = trackDictionary[@"country"];
        if (!previewURLString && !previewURL && !city && !country) {
            self.errorMessage = [self.errorMessage stringByAppendingString:@"Problem parsing trackDictionary\n"];
            return;
        }
        SearchedCity *searchedCity = [[SearchedCity alloc] initWithCity:city country:country previewURL:previewURL index:index];
        [self.cities addObject:searchedCity];
        index++;
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
