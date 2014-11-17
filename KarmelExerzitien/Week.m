//
//  Week.m
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 05.09.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "Week.h"

@implementation Week

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		_week_id = [[aDecoder decodeObjectForKey:@"week_id"] integerValue];
		_week_title = [aDecoder decodeObjectForKey:@"week_title"];
		_impulse = [aDecoder decodeObjectForKey:@"impulse"];
		_image = [aDecoder decodeObjectForKey:@"image"];
		_image_desc = [aDecoder decodeObjectForKey:@"image_desc"];
		_audio_link = [aDecoder decodeObjectForKey:@"audio_link"];
		_audio_desc = [aDecoder decodeObjectForKey:@"audio_desc"];
		_video_link = [aDecoder decodeObjectForKey:@"video_link"];
		_video_desc = [aDecoder decodeObjectForKey:@"video_desc"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(_week_id) forKey:@"week_id"];
	[aCoder encodeObject:_week_title forKey:@"week_title"];
	[aCoder encodeObject:_impulse forKey:@"impulse"];
	[aCoder encodeObject:_image forKey:@"image"];
	[aCoder encodeObject:_image_desc forKey:@"image_desc"];
	[aCoder encodeObject:_audio_link forKey:@"audio_link"];
	[aCoder encodeObject:_audio_desc forKey:@"audio_desc"];
	[aCoder encodeObject:_video_link forKey:@"video_link"];
	[aCoder encodeObject:_video_desc forKey:@"video_desc"];
}

@end
