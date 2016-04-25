//
//  FisherInfoViewController.m
//  fishackthon
//
//  Created by seanh on 4/24/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import "FisherInfoViewController.h"
#import "FisherInfoTableViewCell.h"
#import "AFNetworking/AFNetworking.h"

@interface FisherInfoViewController ()

@end

@implementation FisherInfoViewController
@synthesize fishersTableView;
NSMutableArray *totalGearsArray;
int indexFisher;
int indexGear;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    fishersTableView.delegate = self;
    fishersTableView.dataSource = self;
    indexFisher = 0;
    indexGear = 0;
    totalGearsArray = [[NSMutableArray alloc]initWithCapacity:0];
    fishersTableView.hidden = YES;
    
}

-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"http://www.cloudas.info/pl1/rest/fishers/all?token=MTEzMjU5OTkwOUNBQUNFZEVvc2UwY0JBSURaQW91UXpSWXVIek9zN2ZPeW9JczVVQVpDTk96UnJSSkI1cVc0Z1pBY1lCWkJSczVaQVpBUEtuYWZUUkhueXpwWFVLR1VaQ3VTSHlIbmVud09YcXk0WkIwWkI0eUptbFJoSlU1b1htODkzWGNMOG5IWTgwWEpSM0F6UlpCRFpBWkMxa1pBRGl3cVpBQ3lyWkE5ZnJBVEg4SHNqM1dUTkJKcGJJMzlDUzQ1c1hEeVdTb3FHUPARKINGLUCKLOVEPARKING" parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        //NSLog(@"JSON: %@", responseObject);
        for (NSDictionary* fisher in responseObject) {
            NSArray *gArray = [fisher objectForKey:@"gears"];
            for (NSDictionary* gear in gArray) {
                NSMutableDictionary* newGear = [[NSMutableDictionary alloc] initWithDictionary:gear copyItems:YES];
                [newGear setObject:[fisher objectForKey:@"id"] forKey:@"fisherId"];
                [totalGearsArray addObject:newGear];
            }
        }
        //fisherArray = responseObject;//[NSJSONSerialization JSONObjectWithData:[responseObject dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        fishersTableView.hidden = NO;
        [fishersTableView reloadData];
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [totalGearsArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"FisherInfoTableViewCell";
    FisherInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    NSDictionary *gear = [totalGearsArray objectAtIndex:indexPath.row];
    cell.fisherIdLabel.text = [gear objectForKey:@"fisherId"];
    cell.gearIdLabel.text = [gear objectForKey:@"gearId"];
    NSURL* aURL = [NSURL URLWithString:[gear objectForKey:@"gearImage"]];
    NSData* data = [[NSData alloc] initWithContentsOfURL:aURL];
    cell.gearImageView.image = [UIImage imageWithData:data];
    cell.typeLabel.text = [gear objectForKey:@"type"];
    //cell.typeLabel.text = [gear objectForKey:@"updatedTime"];
    cell.stateLabel.text = [[gear objectForKey:@"state"] boolValue]?@"遺失":@"使用中";
    if ([[gear objectForKey:@"state"] boolValue]) {
        cell.stateLabel.backgroundColor = [UIColor redColor];
    }else
        cell.stateLabel.backgroundColor = [UIColor colorWithRed:82.0/255.0 green:155.0/255.0 blue:250.0/255.0 alpha:1.0];
    return cell;
}

-(IBAction)dismissView:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
