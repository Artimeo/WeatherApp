//
//  SearchedCity.h
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchedCity : NSObject
@property (nonatomic, strong, readonly) NSString *city;
@property (nonatomic, strong, readonly) NSString *country;
@property (nonatomic, readonly, strong) NSURL *previewURL;
@property (nonatomic, readonly, assign) int index;

- (instancetype)initWithCity:(NSString *)city country:(NSString *)country previewURL:(NSURL *)previewURL index:(int) index;
@end
