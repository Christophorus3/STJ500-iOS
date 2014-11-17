//
//  ESDonateViewController.m
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 17.11.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESDonateViewController.h"

@interface ESDonateViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem *revealButton;

@end

@implementation ESDonateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	SWRevealViewController *revealViewController = self.revealViewController;
	if ( revealViewController )
	{
		[self.revealButton setTarget: self.revealViewController];
		[self.revealButton setAction: @selector(revealToggle:)];
		//[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
	}
}
- (IBAction)donate:(id)sender {
	NSURL *url = [NSURL URLWithString:NSLocalizedString(@"paypal", nil)];
	[[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
