//
//  ViewController.h
//  fish-light
//
//  Created by seanh on 4/23/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SelectedDelagate <NSObject>

-(void) selected: (NSDictionary*) selectItem;

@end

@interface ViewController : UIViewController <SelectedDelagate>

@property (weak, nonatomic) IBOutlet UIButton* onButton;
@property (weak, nonatomic) IBOutlet UITextField* idTextField;
@property (weak, nonatomic) IBOutlet UIButton* offButton;
@property (weak, nonatomic) IBOutlet UIImageView* gearImage;
@property (weak, nonatomic) IBOutlet UILabel* gearLabel;

-(IBAction)onLight:(id)sender;
-(IBAction)offLight:(id)sender;
-(IBAction)startToSearch:(id)sender;


@end

