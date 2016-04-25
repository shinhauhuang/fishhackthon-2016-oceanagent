//
//  FisherInfoViewController.h
//  fishackthon
//
//  Created by seanh on 4/24/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FisherInfoViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView* fishersTableView;

-(IBAction)dismissView:(id)sender;

@end
