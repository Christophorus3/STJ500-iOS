//
//  ESDayContentController.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"
#import "ESAboutViewController.h"

@interface ESDayContentController : UITabBarController<ESAboutViewDelegate>

@property (nonatomic, strong) Day *day;
@property (nonatomic, weak) ESAboutViewController *about;

- (void)showAbout:(id)sender;

@end