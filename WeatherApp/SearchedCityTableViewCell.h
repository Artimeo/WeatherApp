//
//  SearchedCityTableViewCell.h
//  WeatherApp
//
//  Created by Artem Buryakov on 06.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchedCityTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *city;
@property (weak, nonatomic) IBOutlet UILabel *country;
@property (weak, nonatomic) IBOutlet UILabel *currentWeather;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescription;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;
@property (weak, nonatomic) IBOutlet UIButton *addCityButton;

@end

