//
//  ESDayContentController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESDayContentController.h"
#import "ESHTMLViewController.h"

@interface ESDayContentController ()

@end

@implementation ESDayContentController

@synthesize day = _day;
@synthesize about = _about;

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Add an About Button to the NavBar
	UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aboutButton];
	[aboutButton addTarget:self action:@selector(showAbout:) forControlEvents:UIControlEventTouchUpInside];
	
	// Prepare the two content Controllers
	ESHTMLViewController *impuls = (ESHTMLViewController *)self.viewControllers[0];
	ESHTMLViewController *evangelium = (ESHTMLViewController *)self.viewControllers[1];
	
	impuls.title = @"Impuls";
	evangelium.title = @"Evangelium";
	
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:[@(self.day.number) stringValue] withExtension:@"html"];
	NSURL *gospelURL = [[NSBundle mainBundle] URLForResource:[[@(self.day.number) stringValue] stringByAppendingString:@"e"] withExtension:@"html"];
	
	impuls.contentURL = contentURL;
	evangelium.contentURL = gospelURL;
	
}

- (void)showAbout:(id)sender
{
	self.about = [self.storyboard instantiateViewControllerWithIdentifier:@"About"];
	UINavigationController *navCon = [[UINavigationController alloc] initWithRootViewController:_about];
	self.about.delegate = self;
	[self presentViewController:navCon animated:YES completion:nil];
	
}

- (void)dismissAbout
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
