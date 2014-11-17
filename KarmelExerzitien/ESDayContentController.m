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

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Add an About Button to the NavBar
	//UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aboutButton];
	//[aboutButton addTarget:self action:@selector(showAbout:) forControlEvents:UIControlEventTouchUpInside];
	
	// Prepare the two content Controllers
	ESHTMLViewController *woche = (ESHTMLViewController *)self.viewControllers[0];
	ESHTMLViewController *tag = (ESHTMLViewController *)self.viewControllers[1];
	ESHTMLViewController *evangelium = (ESHTMLViewController *)self.viewControllers[2];
	
	//impuls.title = @"Impuls";
	//evangelium.title = @"Evangelium";
	
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:[@(self.day.number) stringValue] withExtension:@"html"];
	NSURL *gospelURL = [[NSBundle mainBundle] URLForResource:@"week" withExtension:@"html"];
	NSString *gospelContent = [self buildContentString];
	
	tag.contentURL = contentURL;
	evangelium.contentURL = gospelURL;
	evangelium.content = gospelContent;
	
}

- (NSString*)buildContentString {
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:@"week" withExtension:@"html"];
	NSString *contentString = [NSString stringWithContentsOfURL:contentURL usedEncoding:nil error:nil];
	NSString *result = [contentString stringByReplacingOccurrencesOfString:@"<verse>" withString:@"Das ist der Testvers!"];
	return result;
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
