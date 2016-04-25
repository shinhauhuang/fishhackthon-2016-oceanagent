//
//  GearTableViewCell.h
//  fish-light
//
//  Created by seanh on 4/24/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GearTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* gearImage;
@property (weak, nonatomic) IBOutlet UILabel* gearLabel;
@property (weak, nonatomic) IBOutlet UILabel* gearState;

@end
