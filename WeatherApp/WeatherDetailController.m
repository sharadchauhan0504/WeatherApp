//
//  WeatherDetailController.m
//  WeatherApp
//
//  Created by Sharad Chauhan on 5/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "WeatherDetailController.h"

@interface WeatherDetailController ()

@end

@implementation WeatherDetailController

@synthesize weatherDetail;
@synthesize detailImageView;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *weather = [weatherDetail objectForKey:@"weather"];
    NSDictionary *insideWeather = [weather firstObject];
    
    NSDictionary *mainTempField = [weatherDetail objectForKey:@"main"];
    NSDictionary *countryFied = [weatherDetail objectForKey:@"sys"];
    
    NSString *descString = [insideWeather valueForKey:@"description"];
    
    
    NSString *urlAdditionString = [insideWeather valueForKey:@"icon"] ;
    NSString *initialURL = @"http://openweathermap.org/img/w/";
    NSString *endURL= @".png";
    NSString *finalURL = [NSString stringWithFormat:@"%@%@%@",initialURL, urlAdditionString, endURL  ];
    
    
    
    dispatch_queue_t loadQ = dispatch_queue_create("DownloadQueue", NULL);
    dispatch_sync(loadQ,
                  ^{
                      NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:finalURL]];
                      // dispatch_async(dispatch_get_main_queue(),
                      //              ^{
                      self.detailImageView.image = [UIImage imageWithData:data];                      //                });
                      
                      
                  });
    
   /* if ([descString isEqualToString:@"moderate rain"] || [descString isEqualToString:@"little rain"]) {
        self.detailImageView.image = [UIImage imageNamed:@"light_rainy.png"];
    }
    else if ([descString isEqualToString:@"clear sky"] || [descString isEqualToString:@"little rain"]) {
        self.detailImageView.image = [UIImage imageNamed:@"sunny.ico"];
    }*/
    
    
    
    
    NSString *cityName = [weatherDetail valueForKey:@"name"];
    
    NSString *temp= [mainTempField valueForKey:@"temp"];
    NSString *minTemp = [mainTempField valueForKey:@"temp_min"];
    NSString *maxTemp = [mainTempField valueForKey:@"temp_max"];
    NSString *humidityString  = [mainTempField valueForKey:@"humidity"];
    
    
    NSString *countryName = [countryFied valueForKey:@"country"];
    NSString *sunRise = [countryFied valueForKey:@"sunrise"];
    NSString *sunSet = [countryFied valueForKey:@"sunset"];

    
    NSTimeInterval sunriseTime = [sunRise doubleValue]; // assume this exists
    NSDate* ts_utc = [NSDate dateWithTimeIntervalSince1970:sunriseTime];
    NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
    [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"IST"]];
    [df_local setDateFormat:@"HH:mm:ss"];
    NSString* ts_local_string = [df_local stringFromDate:ts_utc];
    
    NSTimeInterval sunsetTime = [sunSet doubleValue]; // assume this exists
    NSDate* nsDateSunset = [NSDate dateWithTimeIntervalSince1970:sunsetTime];
    NSDateFormatter* sunsetLocal = [[NSDateFormatter alloc] init];
    [sunsetLocal setTimeZone:[NSTimeZone timeZoneWithName:@"IST"]];
    [sunsetLocal setDateFormat:@"HH:mm:ss"];
    NSString* sunsetString = [df_local stringFromDate:nsDateSunset];
    
    
   
    int tempNormal = [temp floatValue] - 273.15;
    int minTempFloat = [minTemp floatValue ] - 273.15;
    int maxTempFloat = [maxTemp floatValue ] - 273.15;
    
    NSString *finalTempNotmal = [NSString stringWithFormat:@"%d",tempNormal];
    NSString *finalMinTemp = [NSString stringWithFormat:@"%d",minTempFloat];
    NSString *finalMaxTemp = [NSString stringWithFormat:@"%d",maxTempFloat];
    
    self.tempNormal.text = [ finalTempNotmal stringByAppendingString:[NSString stringWithFormat:@"%@C", @"\u00B0"]];
    self.minTemp.text = [ finalMinTemp stringByAppendingString:[NSString stringWithFormat:@"%@C", @"\u00B0"] ];
    self.maxTemp.text = [ finalMaxTemp stringByAppendingString:[NSString stringWithFormat:@"%@C", @"\u00B0"] ];
    
    self.decriptionString.text = descString;
    
    self.cityName.text = cityName;
    self.countryName.text = countryName;
    self.humidity.text = [NSString stringWithFormat:@"%@",humidityString];
    
    self.sunrise.text = ts_local_string;
    self.sunset.text = sunsetString;
    
    
    
    
    
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
