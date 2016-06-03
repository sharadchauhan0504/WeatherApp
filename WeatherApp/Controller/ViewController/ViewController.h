//
//  ViewController.h
//  WeatherApp
//
//  Created by Sharad Chauhan on 5/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking/AFNetworking.h>
#import <SpinKit/RTSpinKitView.h>
#import "WeatherDetailController.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *myImageView;
@property (strong, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) IBOutlet UISearchBar *searchCity;
@property (strong, nonatomic) IBOutlet UIButton *goButton;
@property (strong, nonatomic) IBOutlet UITextView *myTextView;

@end

