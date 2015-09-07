//
//  KAboutViewController.m
//  STJ500
//
//  Created by Secretarius on 27.02.15.
//  Copyright (c) 2015 Christoph Wottawa. All rights reserved.
//

#import "KAboutViewController.h"

@interface KAboutViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem *revealButton;

@end

@implementation KAboutViewController

- (void)viewDidLoad
{
    //self.contentURL = [[NSBundle mainBundle] URLForResource:NSLocalizedString(@"pjacques", nil) withExtension:@"html"];
    self.contentURL = [[NSBundle mainBundle] URLForResource:@"about" withExtension:@"html"];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([request.URL.absoluteString rangeOfString:@"fb.at"].location != NSNotFound) {
        NSURL *fbapp = [NSURL URLWithString:@"fb://profile/482656151779152"];
        NSURL *fburl = [NSURL URLWithString:@"http://www.facebook.com/karmeliten.wien"];
        
        if ([[UIApplication sharedApplication] canOpenURL:fbapp]) {
            [[UIApplication sharedApplication] openURL:fbapp];
        } else {
            [[UIApplication sharedApplication] openURL:fburl];
        }
        return NO;
    }
    if ([request.URL.absoluteString rangeOfString:@"fb.en"].location != NSNotFound) {
        NSURL *fbapp = [NSURL URLWithString:@"fb://profile/1535692133349103"];
        NSURL *fburl = [NSURL URLWithString:@"http://www.facebook.com/STJ500StTeresa"];
        
        if ([[UIApplication sharedApplication] canOpenURL:fbapp]) {
            [[UIApplication sharedApplication] openURL:fbapp];
        } else {
            [[UIApplication sharedApplication] openURL:fburl];
        }
        return NO;
    }
    
    if ([request.URL.absoluteString rangeOfString:@"fb.fr"].location != NSNotFound) {
        NSURL *fbapp = [NSURL URLWithString:@"fb://profile/102972926460103"];
        NSURL *fburl = [NSURL URLWithString:@"http://www.facebook.com/carmesparis"];
        
        if ([[UIApplication sharedApplication] canOpenURL:fbapp]) {
            [[UIApplication sharedApplication] openURL:fbapp];
        } else {
            [[UIApplication sharedApplication] openURL:fburl];
        }
        return NO;
    }

    
    if ([request.URL.absoluteString rangeOfString:@"www"].location != NSNotFound) {
        [[UIApplication sharedApplication] openURL:request.URL];
        return NO;
    }
    
    return YES;
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
