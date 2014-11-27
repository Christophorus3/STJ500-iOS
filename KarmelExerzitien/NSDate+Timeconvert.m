//
//  NSDate+Timeconvert.m
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 18.11.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "NSDate+Timeconvert.h"

@implementation NSDate (Timeconvert)

-(NSDate *) toLocalTime
{
	NSTimeZone *tz = [NSTimeZone defaultTimeZone];
	NSInteger seconds = [tz secondsFromGMTForDate: self];
	return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}

-(NSDate *) toGlobalTime
{
	NSTimeZone *tz = [NSTimeZone defaultTimeZone];
	NSInteger seconds = -[tz secondsFromGMTForDate: self];
	return [NSDate dateWithTimeInterval: seconds sinceDate: self];
}


@end
