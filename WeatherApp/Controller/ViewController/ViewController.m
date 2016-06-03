//
//  ViewController.m
//  WeatherApp
//
//  Created by Sharad Chauhan on 5/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSArray *animationFrames;
    NSDictionary *jsonDictionary;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.weatherLabel.layer.cornerRadius =5;
    self.weatherLabel.layer.borderColor= [UIColor purpleColor].CGColor;
    self.weatherLabel.layer.borderWidth= 1.0f;
    self.weatherLabel.layer.masksToBounds = YES;
    self.myTextView.layer.cornerRadius = 5.0f;
    self.myTextView.layer.masksToBounds= YES;
    self.goButton.layer.cornerRadius = 2.0f;
    self.goButton.layer.masksToBounds =YES;
    self.searchCity.layer.cornerRadius = 5.0f;
    self.searchCity.layer.masksToBounds =YES;
    
    animationFrames = [NSArray arrayWithObjects:[UIImage imageNamed: @"sunny.ico"],[UIImage imageNamed:@"partly_sunny.png"],[UIImage imageNamed: @"cloudy.png"],[UIImage imageNamed: @"day_partly_cloudy.gif.png"],[UIImage imageNamed: @"light_rainy.png"],[UIImage imageNamed: @"thunderstorm-rain.png"], nil];
    
    self.myImageView.animationImages = animationFrames;
    self.myImageView.animationDuration = 7;
    self.myImageView.animationRepeatCount = 0;
    [self.myImageView startAnimating];
    
    
    
}



#pragma mark - Fetching Data -
- (IBAction)goSearchingStart:(id)sender {
    
    NSString *urlAdditionString =  self.searchCity.text;
    NSString *initialURL = @"http://api.openweathermap.org/data/2.5/weather?q=";
    NSString *endURL= @"&appid=a0451f4181eadbdf7e44b23f9a91a826";
    NSString *finalURL = [NSString stringWithFormat:@"%@%@%@",initialURL, urlAdditionString, endURL  ];
    
    RTSpinKitView *spinner = [[RTSpinKitView alloc] initWithStyle:RTSpinKitViewStyleBounce color:[UIColor purpleColor]spinnerSize:50];
    [spinner setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2)];
    [self.view addSubview:spinner];
    [spinner bringSubviewToFront:spinner];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
                                [spinner startAnimating];
                                NSURL *url = [NSURL URLWithString:finalURL];
                                NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                                AFURLSessionManager *manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
                                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                                NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response,id responseObject, NSError *error) {
                                    [spinner stopAnimating];
                                    if (error) {
                                            NSLog(@"\n Error --> %@",error);
                                    }
                                    else{
                                            jsonDictionary = (NSDictionary*) responseObject;
                                            WeatherDetailController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"WeatherDetailController"];
                                            controller.weatherDetail = jsonDictionary;
                                            _searchCity.text = @"";
                                            [self.navigationController pushViewController:controller animated:YES];
                                    }
                                }];
                                [dataTask resume];
    
                });
    

}
#pragma mark - didReceiveMemoryWarning -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
