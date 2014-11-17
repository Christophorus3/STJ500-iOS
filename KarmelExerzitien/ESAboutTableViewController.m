//
//  ESAboutTableViewController.m
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 17.11.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESAboutTableViewController.h"

@interface ESAboutTableViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem *revealButton;

@end

@implementation ESAboutTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	SWRevealViewController *revealViewController = self.revealViewController;
	
	if ( revealViewController )
	{
		[self.revealButton setTarget: self.revealViewController];
		[self.revealButton setAction: @selector( revealToggle: )];
		//[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
	}

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell.reuseIdentifier isEqualToString:@"karmel"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://wien.karmel.at"]];
	}
	if ([cell.reuseIdentifier isEqualToString:@"marienschwestern"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.marienschwestern.at"]];
	}
	if ([cell.reuseIdentifier isEqualToString:@"esgö"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.edith-stein-gesellschaft.at"]];
	}
	if ([cell.reuseIdentifier isEqualToString:@"fb"]) {
		
		NSURL *fbapp = [NSURL URLWithString:@"fb://profile/482656151779152"];
		NSURL *fburl = [NSURL URLWithString:@"http://www.facebook.com/karmeliten.wien"];
		
		if ([[UIApplication sharedApplication] canOpenURL:fbapp]) {
			[[UIApplication sharedApplication] openURL:fbapp];
		} else {
			[[UIApplication sharedApplication] openURL:fburl];
		}
	}
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	if ([cell.reuseIdentifier isEqualToString:@"karmel"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://wien.karmel.at"]];
	}
	if ([cell.reuseIdentifier isEqualToString:@"marienschwestern"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.marienschwestern.at"]];
	}
	if ([cell.reuseIdentifier isEqualToString:@"esgö"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.edith-stein-gesellschaft.at"]];
	}
	if ([cell.reuseIdentifier isEqualToString:@"fb"]) {
		
		NSURL *fbapp = [NSURL URLWithString:@"fb://profile/482656151779152"];
		NSURL *fburl = [NSURL URLWithString:@"http://www.facebook.com/karmeliten.wien"];
		
		if ([[UIApplication sharedApplication] canOpenURL:fbapp]) {
			[[UIApplication sharedApplication] openURL:fbapp];
		} else {
			[[UIApplication sharedApplication] openURL:fburl];
		}
	}
}

#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}*/

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
