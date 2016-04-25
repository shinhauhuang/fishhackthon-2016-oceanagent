//
//  SelectedTableViewController.h
//  fish-light
//
//  Created by seanh on 4/24/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SelectedTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property(weak, nonatomic) IBOutlet UITableView *gearsTableView;
@property(strong, nonatomic) NSArray* gearsArray;
@property(strong, nonatomic) id<SelectedDelagate> delegate;


@end
