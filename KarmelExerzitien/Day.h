//
//  ESDay.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 20.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Day : NSObject <NSCoding>

/*
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *headline;

@property (nonatomic) int number;

@property (nonatomic) NSString *lang;
*/
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *lit_name;
@property (nonatomic) NSString *lit_name2;
@property (nonatomic) NSString *teresa_ref;
@property (nonatomic) NSString *teresa_short;
@property (nonatomic) NSString *teresa_text;

@property (nonatomic) NSURL *image;
@property (nonatomic) NSData *imageData;

@property (nonatomic) NSString *bible_ref;
@property (nonatomic) NSString *bible_text;

@property (nonatomic) NSURL *audio;
@property (nonatomic) NSString *audio_desc;

@property (nonatomic) NSString *video_ref;
@property (nonatomic) NSString *video_desc;

- (NSString *)dateDescription;


@end
