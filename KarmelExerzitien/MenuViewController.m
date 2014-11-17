//
//  MenuViewController.m
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import "MenuViewController.h"
//#import "ColorViewController.h"

@implementation SWUITableViewCell
@end

@implementation MenuViewController


- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
	
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";

    switch ( indexPath.row )
    {
        case 0:
            CellIdentifier = @"kalender";
            break;
            
        case 1:
            CellIdentifier = @"uber";
            break;

        case 2:
            CellIdentifier = @"kontakt";
            break;
			
		case 3:
			CellIdentifier = @"gebetsanliegen";
			break;
		
		case 4:
			CellIdentifier = @"spenden";
			break;
			
		case 5:
			CellIdentifier = @"einstellungen";
			break;



    }*/

    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier forIndexPath: indexPath];
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
 
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	
	
	if([cell.reuseIdentifier isEqualToString:@"kontakt"]) {
		self.mailComposer = [[MFMailComposeViewController alloc] init];
		self.mailComposer.mailComposeDelegate = self;
		[self.mailComposer setToRecipients:@[@"online-exerzitien@karmel.at"]];
		[self.mailComposer setSubject:@""];
		[self.mailComposer setMessageBody:@"" isHTML:YES];
		[self presentViewController:self.mailComposer animated:YES completion:nil];
	}
	
	if([cell.reuseIdentifier isEqualToString:@"gebetsanliegen"]) {
		self.mailComposer = [[MFMailComposeViewController alloc] init];
		self.mailComposer.mailComposeDelegate = self;
		[self.mailComposer setToRecipients:@[@"online-exerzitien@karmel.at"]];
		[self.mailComposer setSubject:NSLocalizedString(@"Gebetsanliegen", nil)];
		[self.mailComposer setMessageBody:NSLocalizedString(@"Ich bitte um Gebet für folgendes Anliegen:", nil) isHTML:YES];
		[self presentViewController:self.mailComposer animated:YES completion:nil];
	}
	
	if([[cell reuseIdentifier] isEqualToString:@"karmel"]) {
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:NSLocalizedString(@"karmel", nil)]];
	}
	
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark state preservation / restoration
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO save what you need here
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO restore what you need here
    
    [super decodeRestorableStateWithCoder:coder];
}

- (void)applicationFinishedRestoringState {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    // TODO call whatever function you need to visually restore
}

@end
