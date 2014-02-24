//
//  ESPageContainerViewController.m
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 24.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESPageContainerViewController.h"
#import "ESPageViewController.h"

@interface ESPageContainerViewController ()

@property (nonatomic, weak) ESPageViewController *pageView;

@end

@implementation ESPageContainerViewController


@synthesize backgroundImageView = _backgroundImageView;
@synthesize pageView = _pageView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	//setup buttons:
	
	if([[UIScreen mainScreen]bounds].size.height == 568) {
		self.backgroundImageView.image = [UIImage imageNamed:@"Background4"];
	} else {
		self.backgroundImageView.image = [UIImage imageNamed:@"Background"];
	}
	
	if(floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
		if([[UIScreen mainScreen]bounds].size.height == 568) {
			self.backgroundImageView.image = [UIImage imageNamed:@"Background4S"];
		} else {
			self.backgroundImageView.image = [UIImage imageNamed:@"BackgroundS"];
		}
	}
	
}

/*
- (IBAction)nextPage {
	if(self.pageView) {
		[self.pageView showNextPage];
	}
}

- (IBAction)previousPage {
	if(self.pageView) {
		[self.pageView showPreviousPage];
	}
}
*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if([segue.identifier isEqualToString:@"EmbedPages"]) {
		self.pageView = segue.destinationViewController;
	}
}

@end
