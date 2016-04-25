//
//  ViewController.m
//  fish-light
//
//  Created by seanh on 4/23/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import "AFNetworking/AFNetworking.h"
#import "SelectedTableViewController.h"

@interface ViewController ()

@property (nonatomic) BOOL torchIsOn;

@end

@implementation ViewController

@synthesize idTextField;

NSMutableArray *totalGearsArray;
int counter;
NSMutableArray *array;
NSTimer * theTimer;
NSDictionary* selectedGear;

-(void)dismissKeyboard {
    [idTextField resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    counter = 0;
    
    array = [[NSMutableArray alloc] init];
    [array addObject:[NSNumber numberWithBool:YES]];
    [array addObject:[NSNumber numberWithBool:YES]];
    [array addObject:[NSNumber numberWithBool:YES]];
    [array addObject:[NSNumber numberWithBool:NO]];
    [array addObject:[NSNumber numberWithBool:YES]];
    [array addObject:[NSNumber numberWithBool:NO]];
    [array addObject:[NSNumber numberWithBool:YES]];
    [array addObject:[NSNumber numberWithBool:YES]];
    [array addObject:[NSNumber numberWithBool:YES]];
    [array addObject:[NSNumber numberWithBool:NO]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    idTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    idTextField.layer.borderWidth=2.0;
    
    
    self.navigationItem.title = @"GEAR EXPLORE";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0];
    
    
    NSDictionary * navigationTextAttributes= [NSDictionary dictionaryWithObjectsAndKeys:
                                              [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                              UITextAttributeTextColor,
                                              [UIFont systemFontOfSize:26],
                                              UITextAttributeFont,nil];
    
    [self.navigationController.navigationBar  setTitleTextAttributes:navigationTextAttributes];
    

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
}


-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setLight:(bool) isOn
{
    
    Class captureDeviceClass = NSClassFromString(@"AVCaptureDevice");
    if (captureDeviceClass != nil) {
        AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        if ([device hasTorch] && [device hasFlash]){
            
            [device lockForConfiguration:nil];
            if (isOn) {
                [device setTorchMode:AVCaptureTorchModeOn];
                [device setFlashMode:AVCaptureFlashModeOn];
                //_torchIsOn = YES; //define as a variable/property if you need to know status
            } else {
                [device setTorchMode:AVCaptureTorchModeOff];
                [device setFlashMode:AVCaptureFlashModeOff];
                //_torchIsOn = NO;
            }
            [device unlockForConfiguration];
        }
    }
}
-(void) sendLight {
   // for (int i = 0; i <10 ; i++) {
    [self setLight:[[array objectAtIndex:counter] boolValue]];
   // }
    counter ++;
    if(counter == 10 )
    {
       [theTimer invalidate];
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:self.idTextField.text message:@"GOOD" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *YesAction = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
////            isValidated = YES;
////            self.lblError.hidden = YES;
//            NSLog(@"Second log");
//            
//            
//        }];
//        [alertController addAction:YesAction];
//        
//        [self presentViewController:alertController animated:YES completion:nil];
    }
}


-(IBAction)onLight:(id)sender
{
    counter = 0;
    if([selectedGear isKindOfClass:[NSDictionary class]])
    {
        NSString *gearId = [selectedGear objectForKey:@"gearId"];
        for (int i = 0; i < gearId.length; i++) {
            NSRange range = NSMakeRange(i,1);
            NSString * oneChar = [gearId substringWithRange:range];
            [array replaceObjectAtIndex:i+1 withObject:[NSNumber numberWithBool:[oneChar boolValue]]];
        }
        theTimer = [NSTimer scheduledTimerWithTimeInterval:0.05f target:self selector:@selector(sendLight) userInfo:nil repeats:YES];
    }
}
-(IBAction)offLight:(id)sender{

}

-(IBAction)startToSearch:(id)sender
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://www.cloudas.info/pl1/rest/fishers/all?token=MTEzMjU5OTkwOUNBQUNFZEVvc2UwY0JBSURaQW91UXpSWXVIek9zN2ZPeW9JczVVQVpDTk96UnJSSkI1cVc0Z1pBY1lCWkJSczVaQVpBUEtuYWZUUkhueXpwWFVLR1VaQ3VTSHlIbmVud09YcXk0WkIwWkI0eUptbFJoSlU1b1htODkzWGNMOG5IWTgwWEpSM0F6UlpCRFpBWkMxa1pBRGl3cVpBQ3lyWkE5ZnJBVEg4SHNqM1dUTkJKcGJJMzlDUzQ1c1hEeVdTb3FHUPARKINGLUCKLOVEPARKING" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        for (NSDictionary* fisher in responseObject) {
            NSString *fisherId = [fisher objectForKey:@"id"];
            if ([fisherId isEqualToString:idTextField.text]) {
                SelectedTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectedTableViewController"];
                totalGearsArray =[fisher objectForKey:@"gears"];
                [vc setValue:totalGearsArray forKey:@"gearsArray"];
                [vc setValue:self forKey:@"delegate"];
                [self dismissKeyboard];
                [self.navigationController pushViewController:vc animated:YES];
                
            }
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
}

-(void) selected: (NSDictionary*) selectItem
{
    selectedGear = selectItem;
    NSURL* aURL = [NSURL URLWithString:[selectItem objectForKey:@"gearImage"]];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    self.gearImage.image = [UIImage imageWithData:data];
    self.gearLabel.text = [selectItem objectForKey:@"gearId"];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Here You can do additional code or task instead of writing with keyboard
    return NO;
}

@end
