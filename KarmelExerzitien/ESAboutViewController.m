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

@property (nonatomic, weak) IBOutlet UIBarButtonItem *revealButton;

@end

@implementation ESAboutViewController

//@synthesize scrollView = _scrollView;
@synthesize mailComposer = _mailComposer;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	//NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AboutView" owner:self options:nil];
	
	//UIView *contentView = [nib objectAtIndex:0];
	
	//[self.view addSubview:contentView];
	//self.scrollView.contentSize = CGSizeMake(320, 920);
	
	/*
	UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
	item.title = @"Fertig";
	item.target = self.delegate;
	item.action = @selector(dismissAbout);
	*/
	//self.navigationItem.leftBarButtonItem = item; //[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self.delegate action:@selector(dismissAbout)];
	
	SWRevealViewController *revealViewController = self.revealViewController;
	if ( revealViewController )
	{
		[self.revealButton setTarget: self.revealViewController];
		[self.revealButton setAction: @selector(revealToggle:)];
		//[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
	}
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
	
}

- (IBAction)websitePixelio:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.pixelio.de"]];
}


- (IBAction)websiteEdithVita:(id)sender
{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.edith-stein-gesellschaft.at/Edith-Stein-Gesellschaft/Lebensdaten"]];
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

- (IBAction)websiteJDO:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.ordensgemeinschaften.at/jahrderorden-aktuelles"]];
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

- (IBAction)sendMail:(id)sender {
	self.mailComposer = [[MFMailComposeViewController alloc] init];
	self.mailComposer.mailComposeDelegate = self;
	[self.mailComposer setToRecipients:@[@"online-exerzitien@karmel.at"]];
	[self.mailComposer setSubject:@"KarmelExerzitien App"];
	[self.mailComposer setMessageBody:@"" isHTML:YES];
	[self presentViewController:self.mailComposer animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissViewControllerAnimated:YES completion:nil];
}



@end
