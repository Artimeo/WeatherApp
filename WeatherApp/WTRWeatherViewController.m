//
//  WTRWeatherViewController.m
//  WeatherApp
//
//  Created by Artem Buryakov on 28.04.2020.
//  Copyright © 2020 Artem Buryakov. All rights reserved.
//

#import "WTRWeatherViewController.h"
#import "CityItem.h"

@interface WTRWeatherViewController()
@property (nonatomic, weak) AppCoordinator *coordinator;
@property (nonatomic, weak) CitiesModel *model;

@property (weak, nonatomic) IBOutlet UILabel *cityTitle;
@property (weak, nonatomic) IBOutlet UILabel *requestDate;
@property (weak, nonatomic) IBOutlet UILabel *weatherTemperature;
@property (weak, nonatomic) IBOutlet UILabel *weatherDescription;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIcon;

@property (weak, nonatomic) IBOutlet UILabel *feelsLike;
@property (weak, nonatomic) IBOutlet UILabel *pressure;
@property (weak, nonatomic) IBOutlet UILabel *windSpeed;
@property (weak, nonatomic) IBOutlet UILabel *sunriseTime;

@property (weak, nonatomic) IBOutlet UILabel *humidity;
@property (weak, nonatomic) IBOutlet UIProgressView *humidityProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *cloudness;
@property (weak, nonatomic) IBOutlet UIProgressView *cloudnessProgressBar;
@property (weak, nonatomic) IBOutlet UILabel *sunsetTime;
@end

@implementation WTRWeatherViewController

- (instancetype)initWithCoordinator:(AppCoordinator *)coordinator Model:(CitiesModel *)model {
    self = [super initWithNibName:@"WTRWeatherView" bundle:nil];
    if (self) {
        _coordinator = coordinator;
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    CityItem *city = self.model.cities.firstObject;
    self.cityTitle.text = city.name;
    self.requestDate.text = @"today";
    self.weatherTemperature.text = [NSString stringWithFormat:@"%.1lf°C", city.temp];
    self.weatherDescription.text = city.weatherDescription;
    self.weatherIcon.image = [UIImage imageNamed: city.weatherIconCode];
    self.feelsLike.text = [NSString stringWithFormat:@"feels like %.1lf°C", city.feelsLike];
    self.pressure.text = [NSString stringWithFormat:@"pressure %ld hPa", city.pressure];
    self.windSpeed.text = [NSString stringWithFormat:@"wind speed %.0lf m/s", city.feelsLike];
    self.sunriseTime.text = [NSString stringWithFormat:@"sunrise\n %@", [dateFormatter stringFromDate:city.sunrise]];
    self.humidity.text = [NSString stringWithFormat:@"humidity %ld\%%", city.humidity];
    [self.humidityProgressBar setProgress:(city.humidity/100.)];
    self.cloudness.text = [NSString stringWithFormat:@"cloudness %ld\%%", city.cloudness];
    [self.cloudnessProgressBar setProgress:(city.cloudness/100.)];
    self.sunsetTime.text = [NSString stringWithFormat:@"sunset\n %@", [dateFormatter stringFromDate:city.sunset]];
}

@end
