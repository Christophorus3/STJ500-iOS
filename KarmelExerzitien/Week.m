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
		_impulse_title = [aDecoder decodeObjectForKey:@"impulse_title"];
		_impulse = [aDecoder decodeObjectForKey:@"impulse"];
		_image = [aDecoder decodeObjectForKey:@"image"];
		_image_desc = [aDecoder decodeObjectForKey:@"image_desc"];
		_video_link = [aDecoder decodeObjectForKey:@"video_link"];
		_video_desc = [aDecoder decodeObjectForKey:@"video_desc"];
		_part1_title = [aDecoder decodeObjectForKey:@"part1_title"];
		_part1 = [aDecoder decodeObjectForKey:@"part1"];
		_part2_title = [aDecoder decodeObjectForKey:@"part2_title"];
		_part2 = [aDecoder decodeObjectForKey:@"part2"];
		_part3_title = [aDecoder decodeObjectForKey:@"part3_title"];
		_part3 = [aDecoder decodeObjectForKey:@"part3"];
		_finale = [aDecoder decodeObjectForKey:@"finale"];

	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:@(_week_id) forKey:@"week_id"];
	[aCoder encodeObject:_week_title forKey:@"week_title"];
	[aCoder encodeObject:_impulse forKey:@"impulse_title"];
	[aCoder encodeObject:_impulse forKey:@"impulse"];
	[aCoder encodeObject:_image forKey:@"image"];
	[aCoder encodeObject:_image_desc forKey:@"image_desc"];
	[aCoder encodeObject:_video_link forKey:@"video_link"];
	[aCoder encodeObject:_video_desc forKey:@"video_desc"];
	[aCoder encodeObject:_part1_title forKey:@"part1_title"];
	[aCoder encodeObject:_part1 forKey:@"part1"];
	[aCoder encodeObject:_part2_title forKey:@"part2_title"];
	[aCoder encodeObject:_part2 forKey:@"part2"];
	[aCoder encodeObject:_part3_title forKey:@"part3_title"];
	[aCoder encodeObject:_part3 forKey:@"part3"];
	[aCoder encodeObject:_finale forKey:@"finale"];
}


@end
