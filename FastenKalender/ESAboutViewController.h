//
//  ESAboutViewController.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 21.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@protocol ESAboutViewDelegate <NSObject>

@required
- (void)dismissAbout;

@end


@interface ESAboutViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) MFMailComposeViewController *mailComposer;
@property (nonatomic, weak) id<ESAboutViewDelegate> delegate;
@property (nonatomic, weak) UIBarButtonItem *dismissButton;


- (IBAction)webSiteESGOE:(id)sender;
- (IBAction)websiteKarmel:(id)sender;
- (IBAction)facebookKarmel:(id)sender;
- (IBAction)sendMail:(id)sender;


@end
