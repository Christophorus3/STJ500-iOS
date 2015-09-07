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
	
	NSDateFormatter *readFormatter = [[NSDateFormatter alloc] init];
	[readFormatter setLocale:[NSLocale currentLocale]];
	[readFormatter setTimeZone:[NSTimeZone systemTimeZone]];
	[readFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [readFormatter dateFromString:self.date];
	
    NSDateFormatter *writeFormatter = [[NSDateFormatter alloc] init];
    [writeFormatter setLocale:[NSLocale currentLocale]];
    [writeFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [writeFormatter setDateStyle:NSDateFormatterFullStyle];
    //[writeFormatter setDateFormat:@"EEEE, d. MMMM"];

    NSString *result = [writeFormatter stringFromDate:date];
	return result;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	if (self) {
		//_lang = [aDecoder decodeObjectForKey:@"lang"];
		
		_date = [aDecoder decodeObjectForKey:@"date"];
		
		_lit_name = [aDecoder decodeObjectForKey:@"lit_name"];
        _lit_name2 = [aDecoder decodeObjectForKey:@"lit_name"];
        
        _teresa_ref = [aDecoder decodeObjectForKey:@"teresa_ref"];
        _teresa_short = [aDecoder decodeObjectForKey:@"teresa_short"];
        _teresa_text = [aDecoder decodeObjectForKey:@"teresa_text"];
        
		_image = [aDecoder decodeObjectForKey:@"image"];
        _imageData = [aDecoder decodeObjectForKey:@"imageDate"];
		
        _bible_ref = [aDecoder decodeObjectForKey:@"bible_ref"];
        _bible_text = [aDecoder decodeObjectForKey:@"bible_text"];
        
        _audio = [aDecoder decodeObjectForKey:@"audio"];
        _audio_desc = [aDecoder decodeObjectForKey:@"audio_desc"];
        
        _video_ref = [aDecoder decodeObjectForKey:@"video_ref"];
        _video_desc = [aDecoder decodeObjectForKey:@"video_desc"];
	}
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	//[aCoder encodeObject:_lang forKey:@"lang"];
	[aCoder encodeObject:_date forKey:@"date"];
	
    [aCoder encodeObject:_lit_name forKey:@"lit_name"];
    [aCoder encodeObject:_lit_name2 forKey:@"lit_name2"];
    
    [aCoder encodeObject:_teresa_ref forKey:@"teresa_ref"];
    [aCoder encodeObject:_teresa_short forKey:@"teresa_short"];
    [aCoder encodeObject:_teresa_text forKey:@"teresa_text"];
    
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeObject:_imageData forKey:@"imageData"];
    
    [aCoder encodeObject:_bible_ref forKey:@"bible_ref"];
    [aCoder encodeObject:_bible_text forKey:@"bible_text"];
    
    [aCoder encodeObject:_audio forKey:@"audio"];
    [aCoder encodeObject:_audio_desc forKey:@"audio_desc"];
    
    [aCoder encodeObject:_video_ref forKey:@"video_ref"];
    [aCoder encodeObject:_video_desc forKey:@"video_desc"];
    
}

@end
