//
//  FisherInfoTableViewCell.h
//  fishackthon
//
//  Created by seanh on 4/24/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FisherInfoTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel* fisherIdLabel;
@property (weak, nonatomic) IBOutlet UILabel* gearIdLabel;
@property (weak, nonatomic) IBOutlet UILabel* timeLabel;
@property (weak, nonatomic) IBOutlet UILabel* typeLabel;
@property (weak, nonatomic) IBOutlet UILabel* stateLabel;
@property (weak, nonatomic) IBOutlet UIImageView* gearImageView;


@end
