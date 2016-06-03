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
    

    // Fethcing and Downloading Icon
    
        NSString *urlAdditionString = [[[weatherDetail objectForKey:@"weather"] firstObject] valueForKey:@"icon"] ;
        NSString *initialURL = @"http://openweathermap.org/img/w/";
        NSString *endURL= @".png";
        NSString *finalURL = [NSString stringWithFormat:@"%@%@%@",initialURL, urlAdditionString, endURL  ];
    
        dispatch_queue_t loadQ = dispatch_queue_create("DownloadQueue", NULL);
        dispatch_sync(loadQ,
                  ^{
                      NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:finalURL]];
                      self.detailImageView.image = [UIImage imageWithData:data];
                    });
    
    // Changing timestamp to Local Date Format
    
        NSString *sunRise = [[weatherDetail objectForKey:@"sys" ]valueForKey:@"sunrise"];
        NSTimeInterval sunriseTime = [sunRise doubleValue];
        NSDate* ts_utc = [NSDate dateWithTimeIntervalSince1970:sunriseTime];
        NSDateFormatter* df_local = [[NSDateFormatter alloc] init];
        [df_local setTimeZone:[NSTimeZone timeZoneWithName:@"IST"]];
        [df_local setDateFormat:@"HH:mm:ss"];
        NSString* ts_local_string = [df_local stringFromDate:ts_utc];
    
        NSString *sunSet = [[weatherDetail objectForKey:@"sys"] valueForKey:@"sunset"];
        NSTimeInterval sunsetTime = [sunSet doubleValue];
        NSDate* nsDateSunset = [NSDate dateWithTimeIntervalSince1970:sunsetTime];
        NSDateFormatter* sunsetLocal = [[NSDateFormatter alloc] init];
        [sunsetLocal setTimeZone:[NSTimeZone timeZoneWithName:@"IST"]];
        [sunsetLocal setDateFormat:@"HH:mm:ss"];
        NSString* sunsetString = [df_local stringFromDate:nsDateSunset];
    
    // Converting Fahrenheit to Celcius
    
        int tempNormal = [[[weatherDetail objectForKey:@"main" ] valueForKey:@"temp"] floatValue] - 273.15;
        int minTempFloat = [[[weatherDetail objectForKey:@"main" ] valueForKey:@"temp_min"] floatValue ] - 273.15;
        int maxTempFloat = [[[weatherDetail objectForKey:@"main" ] valueForKey:@"temp_max"] floatValue ] - 273.15;
    
    // Changing Label Color According To Temprature Value
    
        if (tempNormal <=20) {
            _tempNormal.textColor = [UIColor blueColor];
        }else if (tempNormal >30)
            {
                _tempNormal.textColor = [UIColor redColor];
            }
        if (minTempFloat <=20) {
            _minTemp.textColor = [UIColor blueColor];
        }else if (minTempFloat >30)
            {
                _minTemp.textColor = [UIColor redColor];
            }
        if (maxTempFloat <=20) {
            _maxTemp.textColor = [UIColor blueColor];
        }else if (maxTempFloat >30)
            {
                _maxTemp.textColor = [UIColor redColor];
            }
    
    // Setting Value to Labels
    
        _tempNormal.text = [ [NSString stringWithFormat:@"%d",(int)([[[weatherDetail objectForKey:@"main" ] valueForKey:@"temp"] floatValue] - 273.15)]stringByAppendingString:[NSString stringWithFormat:@"%@C", @"\u00B0"]];
        _minTemp.text = [ [NSString stringWithFormat:@"%d",(int)([[[weatherDetail objectForKey:@"main" ] valueForKey:@"temp_min"] floatValue ] - 273.15)] stringByAppendingString:[NSString stringWithFormat:@"%@C", @"\u00B0"] ];
        _maxTemp.text = [ [NSString stringWithFormat:@"%d",(int)([[[weatherDetail objectForKey:@"main" ] valueForKey:@"temp_max"] floatValue ] - 273.15)] stringByAppendingString:[NSString stringWithFormat:@"%@C", @"\u00B0"] ];
        _decriptionString.text = [[[weatherDetail objectForKey:@"weather"] firstObject] valueForKey:@"description"];
        _cityName.text = [weatherDetail valueForKey:@"name"];
        _countryName.text = [[weatherDetail objectForKey:@"sys"] valueForKey:@"country"];
        _humidity.text = [NSString stringWithFormat:@"%@",[[weatherDetail objectForKey:@"main"] valueForKey:@"humidity"]];
        _sunrise.text = ts_local_string;
        _sunset.text = sunsetString;
    
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
