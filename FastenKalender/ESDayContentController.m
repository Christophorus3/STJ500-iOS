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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	ESHTMLViewController *impuls = (ESHTMLViewController *)self.viewControllers[0];
	ESHTMLViewController *evangelium = (ESHTMLViewController *)self.viewControllers[1];
	
	impuls.title = @"Impuls";
	evangelium.title = @"Evangelium";
	
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:[@(self.day.number) stringValue] withExtension:@"html"];
	NSURL *gospelURL = [[NSBundle mainBundle] URLForResource:[[@(self.day.number) stringValue] stringByAppendingString:@"e"] withExtension:@"html"];
	
	
	impuls.contentURL = contentURL;
	evangelium.contentURL = gospelURL;
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
