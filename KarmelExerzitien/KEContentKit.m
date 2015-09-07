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


@interface KEContentKit()
{
	KEPersistencyManager *persistencyManager;
	KEFetcher *fetcher;
	BOOL isOnline;
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
		//persistencyManager = [[KEPersistencyManager alloc] init];
		//fetcher = [[KEFetcher alloc] init];
        
		
		//weekCache = [NSMutableArray array];
		
		//[[NSNotificationCenter defaultCenter] addObserver:self
		//										 selector:@selector(downloadData:)
		//											 name:@"KEDownloadDayNotification"
		//										   object:nil];
        
	}
	
	return self;
}


- (void)downloadData:(NSNotification*)notification
{
	ESDayViewController *dayView = [notification userInfo][@"viewController"];
	NSString *fetchDate = [notification userInfo][@"date"];
	
	
	//dayView.day = [persistencyManager getImage:[coverUrl lastPathComponent]];
	
	if(!dayView.day) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PFQuery *query = [PFQuery queryWithClassName:NSLocalizedString(@"Calendar", nil)];
            [query whereKey:@"date" equalTo:fetchDate];
            query.limit = 1;
            query.cachePolicy = kPFCachePolicyCacheElseNetwork;
            
            Day *day = [[Day alloc] init];
            NSError *error;
            PFObject *object = [query getFirstObject:&error];
            
            if(!error) {
                //PFObject *object = foundObjects[0];
                
                day.date = object[@"date"];
                
                day.lit_name = object[@"lit_name"];
                day.lit_name2 = object[@"lit_name2"];
                day.teresa_ref = object[@"teresa_ref"];
                day.teresa_short = object[@"teresa_short"];
                day.teresa_text = object[@"teresa_text"];
                
                day.bible_ref = object[@"bible_ref"];
                day.bible_text = object[@"bible_text"];
                
                /*
                if(object[@"audio"]) {
                    PFFile *audio = object[@"audio"];
                    day.audio = [NSURL URLWithString:[audio url]];
                    day.audio_desc = object[@"audio_desc"];
                }*/
                
                /*
                if(object[@"video_ref"]) {
                    day.video_ref = object[@"video_ref"];
                    day.video_desc = object[@"video_desc"];
                }*/
                
                PFQuery *query = [PFQuery queryWithClassName:@"Images"];
                [query whereKey:@"date" equalTo:fetchDate];
                query.cachePolicy = kPFCachePolicyCacheElseNetwork;
                PFObject *imageObj = [query getFirstObject];
                if(imageObj) {
                    
                    PFFile *image = imageObj[@"image"];
                    day.image = [NSURL URLWithString:[image url]];
                    day.imageData = [image getData];
                    
                    dayView.day = day;
                }
                
            }
            
            

        });
	}
}

- (void)dealloc {
	//[[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
