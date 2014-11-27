//
//  KEContentKit.m
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 05.09.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "KEContentKit.h"
#import "KEPersistencyManager.h"
#import "KEFetcher.h"

#import "ESDayViewController.h"
#import "Week.h"

@interface KEContentKit()
{
	KEPersistencyManager *persistencyManager;
	KEFetcher *fetcher;
	BOOL isOnline;
	NSMutableArray *weekCache;
}

@end

@implementation KEContentKit

+ (KEContentKit *)sharedInstance {
	
	static KEContentKit *_sharedInstance;
	
	if(!_sharedInstance) {
		_sharedInstance = [[KEContentKit alloc] init];
	}
	
	return _sharedInstance;
}

- (id)init {
	self = [super init];
	
	if(self) {
		persistencyManager = [[KEPersistencyManager alloc] init];
		fetcher = [[KEFetcher alloc] init];
		
		weekCache = [NSMutableArray array];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(downloadData:)
													 name:@"KEDownloadDayNotification"
												   object:nil];
	}
	
	return self;
}


- (void)downloadData:(NSNotification*)notification
{
	ESDayViewController *dayView = [notification userInfo][@"viewController"];
	NSDate *fetchDate = [notification userInfo][@"date"];
	
	
	//dayView.day = [persistencyManager getImage:[coverUrl lastPathComponent]];
	
	if(!dayView.day) {
		
		PFQuery *query = [PFQuery queryWithClassName:NSLocalizedString(@"Day_de", nil)];
		[query whereKey:@"date" equalTo:[fetchDate toLocalTime]];
		query.limit = 1;
		query.cachePolicy = kPFCachePolicyCacheElseNetwork;
		
		__block Day *day = [[Day alloc] init];
		
		[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
			
			if(!error) {
				PFObject *object = objects[0];
				
				day.date = object[@"date"];
				day.week_id = [object[@"week_id"] intValue];
				day.lit_day = object[@"lit_day"];
				day.title = object[@"title"];
				PFFile *image = object[@"title_img"];
				day.title_image = [NSURL URLWithString:[image url]];
				day.bible_verse = object[@"bible_verse"];
				day.impulse = object[@"impulse"];
				day.image = object[@"image"];
				day.call_gospel = object[@"call_gospel"];
				day.verse_gospel = object[@"verse_gospel"];
				day.gospel = object[@"gospel"];
				day.gospel_reader = object[@"gospel_reader"];
				day.reader_image = object[@"reader_image"];
				PFFile *audio = object[@"gospel_audio"];
				day.gospel_audio = [NSURL URLWithString:[audio url]];
				
				dayView.day = day;
				
				if(!dayView.week) {
					//if(weekCache[dayView.day.week_id]) {
					//	dayView.week = weekCache[dayView.day.week_id];
					//}
					
					PFQuery *query = [PFQuery queryWithClassName:NSLocalizedString(@"Week_de", nil)];
					[query whereKey:@"week_id" equalTo:@(dayView.day.week_id)];
					query.cachePolicy = kPFCachePolicyCacheElseNetwork;
					
					__block Week *week = [[Week alloc] init];
					
					[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
						
						if(!error) {
							PFObject *object = objects[0];
							
							week.week_id = [object[@"week_id"] intValue];
							week.week_title = object[@"week_title"];
							week.impulse_title = object[@"impulse_title"];
							week.impulse = object[@"impulse"];
							PFFile *image = object[@"image"];
							week.image = [NSURL URLWithString:[image url]];
							week.image_desc = object[@"image_desc"];
							week.video_link = object[@"video_link"];
							week.video_desc = object[@"video_desc"];
							week.part1_title = object[@"part1_title"];
							week.part1 = object[@"part1"];
							week.part2_title = object[@"part2_title"];
							week.part2 = object[@"part2"];
							week.part3_title = object[@"part3_title"];
							week.part3 = object[@"part3"];
							week.finale = object[@"finale"];
							
							//weekCache[dayView.day.week_id] = week;
							dayView.week = week;
						}
					}];
				}

			}
		}];
		
	}
	
	}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
