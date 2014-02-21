//
//  ESPageViewController.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESPageViewController : UIPageViewController<UIPageViewControllerDataSource>

@property (nonatomic, strong) NSArray *days;
@property (nonatomic) int currentDay;

@end
