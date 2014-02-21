//
//  ESCalenderViewController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 08.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESCalenderViewController.h"
#import "DayCell.h"
#import "ESMonthHeader.h"

@interface ESCalenderViewController ()

@property (nonatomic, strong) NSArray *marchDays;

@end

@implementation ESCalenderViewController

@synthesize marchDays = _marchDays;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	NSMutableArray *temp = [NSMutableArray array];
	for (int i = 1; i <= 31; i++) {
		[temp addObject:[NSNumber numberWithInt:i]];
	}
	self.marchDays = [NSArray arrayWithArray:temp];
	
	
	self.navigationItem.backBarButtonItem.title = @"Kalender";
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayCell" forIndexPath:indexPath];
	
	cell.label.text = [self.marchDays[indexPath.item] stringValue];
	
	return cell;
	
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
	ESMonthHeader *header = (ESMonthHeader *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MonthHeader" forIndexPath:indexPath];
	header.headerLabel.text = @"März";
	
	return header;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return self.marchDays.count;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
