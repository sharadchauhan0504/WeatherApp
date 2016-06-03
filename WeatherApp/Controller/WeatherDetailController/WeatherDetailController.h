//
//  WeatherDetailController.h
//  WeatherApp
//
//  Created by Sharad Chauhan on 5/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherDetailController : UIViewController

@property (strong, nonatomic) NSDictionary *weatherDetail;

@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;
@property (strong, nonatomic) IBOutlet UILabel *decriptionString;
@property (strong, nonatomic) IBOutlet UILabel *tempNormal;
@property (strong, nonatomic) IBOutlet UILabel *maxTemp;
@property (strong, nonatomic) IBOutlet UILabel *minTemp;
@property (strong, nonatomic) IBOutlet UILabel *countryName;
@property (strong, nonatomic) IBOutlet UILabel *cityName;
@property (strong, nonatomic) IBOutlet UILabel *humidity;
@property (strong, nonatomic) IBOutlet UILabel *sunrise;
@property (strong, nonatomic) IBOutlet UILabel *sunset;

@end
