//
//  ESContactViewController.m
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 15.11.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESTeresaViewController.h"

@interface ESTeresaViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem *revealButton;

@end

@implementation ESTeresaViewController


- (void)viewDidLoad
{
    //self.contentURL = [[NSBundle mainBundle] URLForResource:NSLocalizedString(@"pjacques", nil) withExtension:@"html"];
	self.contentURL = [[NSBundle mainBundle] URLForResource:@"teresa" withExtension:@"html"];
	self.content = [NSString stringWithContentsOfURL:self.contentURL encoding:NSUTF8StringEncoding error:nil];
	self.automaticallyAdjustsScrollViewInsets = NO;
	
	[super viewDidLoad];
    // Do any additional setup after loading the view.
	
	SWRevealViewController *revealViewController = self.revealViewController;
	
	if ( revealViewController )
	{
		[self.revealButton setTarget: self.revealViewController];
		[self.revealButton setAction: @selector( revealToggle: )];
		//[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
	}
	[self updateContentInsetsForInterfaceOrientation:self.interfaceOrientation];
}

- (void)viewDidLayoutSubviews {
    self.webView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)updateContentInsetsForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        UIEdgeInsets insets;
		
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            insets = UIEdgeInsetsMake(64, 0, 0, 0);
        } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (UIInterfaceOrientationIsPortrait(orientation)) {
                insets = UIEdgeInsetsMake(64, 0, 0, 0);
            } else {
                insets = UIEdgeInsetsMake(52, 0, 0, 0);
            }
        }
		
        self.webView.scrollView.contentInset = insets;
        self.webView.scrollView.scrollIndicatorInsets = insets;
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
