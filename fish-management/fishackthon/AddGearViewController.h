//
//  AddGearViewController.h
//  fishackthon
//
//  Created by seanh on 4/23/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddGearViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView* gearImageView;
@property (weak, nonatomic) IBOutlet UITextField* userTextField;
@property (weak, nonatomic) IBOutlet UICollectionView* gearCollectionView;
@property (weak, nonatomic) IBOutlet UIButton* addButton;
@property (weak, nonatomic) IBOutlet UIButton* cancelButton;
@property (weak, nonatomic) IBOutlet UIButton* takePicButton;

@property (weak, nonatomic) IBOutlet UIImageView* idImageView;
@property (weak, nonatomic) IBOutlet UIImageView* cameraImageView;
@property (weak, nonatomic) IBOutlet UIImageView* typeImageView;

-(IBAction) takePic:(id)sender;
-(IBAction) summit:(id)sender;
-(IBAction) cancel:(id)sender;

@end
