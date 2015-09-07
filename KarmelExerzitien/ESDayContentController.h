//
//  ESDayContentController.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "Day.h"

@interface ESDayContentController : UITabBarController

@property (nonatomic, strong) Day *day;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSString *formattedDateString;

@end