//
//  ESPageViewController.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ESPageViewController : UIPageViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, strong) NSArray *days;
@property (nonatomic, strong) NSMutableDictionary *dayCache;
@property (nonatomic) int currentPage;


@end
