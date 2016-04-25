//
//  AddGearViewController.m
//  fishackthon
//
//  Created by seanh on 4/23/16.
//  Copyright © 2016 Pakringluck. All rights reserved.
//

#import "AddGearViewController.h"
#import "GearCollectionViewCell.h"
#import "FontAwesomeKit/FAKFontAwesome.h"

@interface AddGearViewController ()

@end

@implementation AddGearViewController
NSMutableArray *gearsArray;

@synthesize gearCollectionView;
@synthesize idImageView;
@synthesize cameraImageView;
@synthesize typeImageView;
@synthesize userTextField;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gearCollectionView.dataSource = self;
    gearCollectionView.delegate = self;
    gearCollectionView.allowsMultipleSelection = NO;
    
    gearsArray = [[NSMutableArray alloc]init];
    [gearsArray addObject:@"Beach Seine"];
    [gearsArray addObject:@"Beam Trawl - Open gear"];
    [gearsArray addObject:@"DRB - Scallop Dredge"];
    [gearsArray addObject:@"Drift Nets"];
    [gearsArray addObject:@"Fyke Net"];
    [gearsArray addObject:@"Jigging"];
    [gearsArray addObject:@"Multi rig - Quad rig"];
    [gearsArray addObject:@"Multi Rig Trawl - nephrops triple rig"];
    [gearsArray addObject:@"Multi Rig Trawl - Sole triple rig"];
    [gearsArray addObject:@"Out-rig Trawling"];
    [gearsArray addObject:@"Pair Trawl"];
    
    FAKFontAwesome *starIcon = [FAKFontAwesome indentIconWithSize:60];
    [starIcon addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *iconImage = [starIcon imageWithSize:CGSizeMake(60, 60)];
    idImageView.image = iconImage;
    
    FAKFontAwesome *starIcon1 = [FAKFontAwesome cameraIconWithSize:60];
    [starIcon1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *iconImage1 = [starIcon1 imageWithSize:CGSizeMake(60, 60)];
    cameraImageView.image = iconImage1;
    
    FAKFontAwesome *starIcon2 = [FAKFontAwesome tagsIconWithSize:60];
    [starIcon2 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *iconImage2 = [starIcon2 imageWithSize:CGSizeMake(60, 60)];
    typeImageView.image = iconImage2;
    
    FAKFontAwesome *starIcon3 = [FAKFontAwesome plusCircleIconWithSize:60];
    [starIcon3 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor]];
    UIImage *iconImage3 = [starIcon3 imageWithSize:CGSizeMake(60, 60)];
    _gearImageView.image = iconImage3;
    
    userTextField.layer.borderColor=[[UIColor whiteColor]CGColor];
    userTextField.layer.borderWidth=2.0;
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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.gearImageView.image = chosenImage;
    self.gearImageView.contentMode = UIViewContentModeScaleToFill;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(IBAction) takePic:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];

}

-(IBAction) summit:(id)sender
{
    
}

-(IBAction) cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [gearsArray count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"GearCollectionViewCell";
    GearCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.gearImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg", [gearsArray objectAtIndex:indexPath.row] ]]];
    if( cell.isSelected)
    {
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }else
    {
        cell.contentView.backgroundColor = [UIColor blackColor];
    }
    //UICollectionViewCell* cell = [[UICollectionViewCell alloc] init];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GearCollectionViewCell *cell = (GearCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GearCollectionViewCell *cell = (GearCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor blackColor];
}

@end
