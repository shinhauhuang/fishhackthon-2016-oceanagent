//
//  ViewController.m
//  fishackthon
//
//  Created by seanh on 4/23/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import "ViewController.h"
#import "FontAwesomeKit/FAKFontAwesome.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController
@synthesize userImageView;
@synthesize pwdImageView;
@synthesize userTextField;
@synthesize pwdTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    FAKFontAwesome *starIcon = [FAKFontAwesome userIconWithSize:60];
    [starIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *iconImage = [starIcon imageWithSize:CGSizeMake(60, 60)];
    [userImageView setImage: iconImage];
    FAKFontAwesome *pwdIcon = [FAKFontAwesome lockIconWithSize:60];
    [pwdIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *pwdiconImage = [pwdIcon imageWithSize:CGSizeMake(60, 60)];
    [pwdImageView setImage: pwdiconImage];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sea_ocean_water.jpg"]];
    userTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    pwdTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    userTextField.layer.borderWidth=2.0;
    pwdTextField.layer.borderWidth=2.0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
