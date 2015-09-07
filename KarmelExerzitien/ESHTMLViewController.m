//
//  ESHTMLViewController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESHTMLViewController.h"

@interface ESHTMLViewController ()

@end

@implementation ESHTMLViewController

@synthesize webView = _webView;
@synthesize contentURL = _contentURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	//NSURLRequest *request = [NSURLRequest requestWithURL:self.contentURL];
	//NSString *contentString = [NSString stringWithContentsOfURL:self.contentURL usedEncoding:nil error:nil];
    _webView.delegate = self;
	[self.webView loadHTMLString:self.content baseURL:self.contentURL];
	
	[self updateContentInsetsForInterfaceOrientation:self.interfaceOrientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateContentInsetsForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        UIEdgeInsets insets;
		
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            insets = UIEdgeInsetsMake(64, 0, 56, 0);
        } else if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (UIInterfaceOrientationIsPortrait(orientation)) {
                insets = UIEdgeInsetsMake(64, 0, 49, 0);
            } else {
                insets = UIEdgeInsetsMake(52, 0, 49, 0);
            }
        }
		
        self.webView.scrollView.contentInset = insets;
        self.webView.scrollView.scrollIndicatorInsets = insets;
    }
}


@end
