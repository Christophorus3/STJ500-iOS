//
//  ESDay.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 20.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESDay.h"

@implementation ESDay

@synthesize name = _name;
@synthesize date = _date;
@synthesize number = _number;
@synthesize headline = _headline;

- (NSString *)dateDescription {
	
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setLocale:[NSLocale currentLocale]];
	[formatter setTimeZone:[NSTimeZone systemTimeZone]];
	[formatter setDateFormat:@"EEEE, d. MMMM"];
	
	NSString *result = [formatter stringFromDate:self.date];
	return result;
}

@end
