//
//  ESDayContentController.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Day.h"
#import "Week.h"

@interface ESDayContentController : UITabBarController

@property (nonatomic, strong) Day *day;
@property (nonatomic, strong) Week *week;


@end