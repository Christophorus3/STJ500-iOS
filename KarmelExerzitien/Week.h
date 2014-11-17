//
//  Week.h
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 05.09.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Week : NSObject <NSCoding>

@property (nonatomic) NSInteger week_id;
@property (nonatomic) NSString *week_title;
@property (nonatomic) NSString *impulse;
@property (nonatomic) NSURL *image;
@property (nonatomic) NSString *image_desc;
@property (nonatomic) NSURL *audio_link;
@property (nonatomic) NSString *audio_desc;
@property (nonatomic) NSURL *video_link;
@property (nonatomic) NSString *video_desc;


@end
