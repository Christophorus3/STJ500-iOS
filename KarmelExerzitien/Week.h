//
//  Week.h
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 05.09.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Week : NSObject <NSCoding>

@property (nonatomic) NSInteger week_id;
@property (nonatomic) NSString *week_title;
@property (nonatomic) NSString *impulse_title;
@property (nonatomic) NSString *impulse;
@property (nonatomic) NSURL *image;
@property (nonatomic) NSString *image_desc;
@property (nonatomic) NSURL *video_link;
@property (nonatomic) NSString *video_desc;
@property (nonatomic) NSString *part1_title;
@property (nonatomic) NSString *part1;
@property (nonatomic) NSString *part2_title;
@property (nonatomic) NSString *part2;
@property (nonatomic) NSString *part3_title;
@property (nonatomic) NSString *part3;
@property (nonatomic) NSString *finale;


@end
