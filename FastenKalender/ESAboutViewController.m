//
//  ESAboutViewController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 21.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESAboutViewController.h"
#import "ESAboutView.h"

@interface ESAboutViewController ()

@end

@implementation ESAboutViewController

@synthesize scrollView = _scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AboutView" owner:self options:nil];
	
	UIView *contentView = [nib objectAtIndex:0];
	
	[self.scrollView addSubview:contentView];
	self.scrollView.contentSize = CGSizeMake(320, 920);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

- (IBAction)webSiteESGOE:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.edith-stein-gesellschaft.at"]];
}

- (IBAction)websiteKarmel:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://wien.karmel.at"]];
}

- (IBAction)websiteMarienschwestern:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.marienschwestern.at"]];
}

- (IBAction)facebookKarmel:(id)sender {
	
	NSURL *fbapp = [NSURL URLWithString:@"fb://profile/482656151779152"];
	NSURL *fburl = [NSURL URLWithString:@"http://www.facebook.com/karmeliten.wien"];
	
	if ([[UIApplication sharedApplication] canOpenURL:fbapp]) {
		[[UIApplication sharedApplication] openURL:fbapp];
	} else {
		[[UIApplication sharedApplication] openURL:fburl];
	}
}
@end
