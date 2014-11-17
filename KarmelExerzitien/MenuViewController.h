//
//  MenuViewController.h
//  RevealControllerStoryboardExample
//
//  Created by Nick Hodapp on 1/9/13.
//  Copyright (c) 2013 CoDeveloper. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface SWUITableViewCell : UITableViewCell

@property (nonatomic) IBOutlet UILabel *label;

@end

@interface MenuViewController : UITableViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) MFMailComposeViewController *mailComposer;

@end
