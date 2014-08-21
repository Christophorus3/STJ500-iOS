//
//  ESPageContainerViewController.h
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 24.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ESAboutViewController.h"
#import "SWRevealViewController/SWRevealViewController.h"

@interface ESPageContainerViewController : UIViewController<ESAboutViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) ESAboutViewController *about;

- (void)showAbout:(id)sender;
- (void)dismissAbout;

@end
