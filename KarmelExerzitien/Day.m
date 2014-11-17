//
//  Day.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 20.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "Day.h"

@implementation Day


- (NSString *)dateDescription {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setLocale:[NSLocale currentLocale]];
	[formatter setTimeZone:[NSTimeZone systemTimeZone]];
	[formatter setDateFormat:@"EEEE, d. MMMM"];
	
	NSString *result = [formatter stringFromDate:self.date];
	return result;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		_lang = [aDecoder decodeObjectForKey:@"lang"];
		
		_date = [aDecoder decodeObjectForKey:@"date"];
		_week_id = [[aDecoder decodeObjectForKey:@"week_id"] integerValue];
		_lit_day = [aDecoder decodeObjectForKey:@"lit_day"];
		_title = [aDecoder decodeObjectForKey:@"title"];
		_title_image = [aDecoder decodeObjectForKey:@"title_image"];
		_bible_verse = [aDecoder decodeObjectForKey:@"bible_verse"];
		_impulse = [aDecoder decodeObjectForKey:@"impulse"];
		_image = [aDecoder decodeObjectForKey:@"image"];
		_audio_link = [aDecoder decodeObjectForKey:@"audio_link"];
		_audio_desc = [aDecoder decodeObjectForKey:@"audio_desc"];
		_video_link = [aDecoder decodeObjectForKey:@"video_link"];
		_video_desc = [aDecoder decodeObjectForKey:@"video_desc"];
		_call_gospel = [aDecoder decodeObjectForKey:@"call_gospel"];
		_verse_gospel = [aDecoder decodeObjectForKey:@"verse_gospel"];
		_gospel = [aDecoder decodeObjectForKey:@"gospel"];
		_reading_link = [aDecoder decodeObjectForKey:@"reading_link"];
		_reading_desc = [aDecoder decodeObjectForKey:@"reading_desc"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:_lang forKey:@"lang"];
	[aCoder encodeObject:_date forKey:@"date"];
	[aCoder encodeObject:@(_week_id) forKey:@"week_id"];
	[aCoder encodeObject:_lit_day forKey:@"lit_day"];
	[aCoder encodeObject:_title forKey:@"title"];
	[aCoder encodeObject:_title_image forKey:@"title_image"];
	[aCoder encodeObject:_bible_verse forKey:@"bible_verse"];
	[aCoder encodeObject:_impulse forKey:@"impulse"];
	[aCoder encodeObject:_image forKey:@"image"];
	[aCoder encodeObject:_audio_link forKey:@"audio_link"];
	[aCoder encodeObject:_audio_desc forKey:@"audio_desc"];
	[aCoder encodeObject:_video_link forKey:@"video_link"];
	[aCoder encodeObject:_video_desc forKey:@"video_desc"];
	[aCoder encodeObject:_call_gospel forKey:@"call_gospel"];
	[aCoder encodeObject:_verse_gospel forKey:@"verse_gospel"];
	[aCoder encodeObject:_gospel forKey:@"gospel"];
	[aCoder encodeObject:_reading_link forKey:@"reading_link"];
	[aCoder encodeObject:_reading_desc forKey:@"reading_desc"];
}

@end
