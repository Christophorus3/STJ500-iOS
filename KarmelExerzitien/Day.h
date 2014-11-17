//
//  ESDay.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 20.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Day : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *headline;

@property (nonatomic) int number;

@property (nonatomic) NSString *lang;

@property (nonatomic) NSDate *date;
@property (nonatomic) NSInteger week_id;
@property (nonatomic) NSString *lit_day;
@property (nonatomic) NSString *title;
@property (nonatomic) NSURL *title_image;
@property (nonatomic) NSString *bible_verse;
@property (nonatomic) NSString *impulse;
@property (nonatomic) NSURL *image;
@property (nonatomic) NSURL *audio_link;
@property (nonatomic) NSString *audio_desc;
@property (nonatomic) NSURL *video_link;
@property (nonatomic) NSString *video_desc;
@property (nonatomic) NSString *call_gospel;
@property (nonatomic) NSString *verse_gospel;
@property (nonatomic) NSString *gospel;
@property (nonatomic) NSURL *reading_link;
@property (nonatomic) NSString *reading_desc;

- (NSString *)dateDescription;


@end
