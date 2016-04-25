//
//  SelectedTableViewController.m
//  fish-light
//
//  Created by seanh on 4/24/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import "SelectedTableViewController.h"
#import "GearTableViewCell.h"
@interface SelectedTableViewController ()

@end

@implementation SelectedTableViewController

@synthesize gearsTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    gearsTableView.delegate = self;
    gearsTableView.dataSource = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"GEARS";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [self.gearsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"GearTableViewCell";
    GearTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *gear = [self.gearsArray objectAtIndex:indexPath.row];
    NSLog(@"%ldJSON: %@",(long)indexPath.row, [gear objectForKey:@"gearImage"]);
    cell.gearLabel.text = [gear objectForKey:@"gearId"];
    NSURL* aURL = [NSURL URLWithString:[gear objectForKey:@"gearImage"]];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    cell.gearImage.image = [UIImage imageWithData:data];
    cell.gearState.text = [[gear objectForKey:@"state"] boolValue]?@"遺失":@"使用中";
    if ([[gear objectForKey:@"state"] boolValue]) {
        cell.gearState.textColor = [UIColor redColor];
    }else
        cell.gearState.textColor = [UIColor colorWithRed:51.0/255.0 green:153.0/255.0 blue:255.0/255.0 alpha:1.0];
    NSLog(@"JSON: %@", [gear objectForKey:@"gearImage"]);
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *gear = [self.gearsArray objectAtIndex:indexPath.row];
    if (_delegate != nil) {
        [_delegate selected:gear];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
