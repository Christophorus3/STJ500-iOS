//
//  ESDayViewController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 06.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESDayViewController.h"
#import "ESDayContentController.h"

@interface ESDayViewController ()

@property (nonatomic, strong) UIImage *dayImage;
@property (atomic, weak) NSArray *days;

@end

@implementation ESDayViewController

@synthesize imageButton = _imageButton;
@synthesize dateLabel = _dateLabel;
@synthesize dayLabel = _dayLabel;
@synthesize titleLabel = _titleLabel;

@synthesize dayImage = _dayImage;

@synthesize index = _index;
@synthesize date = _date;

@synthesize day = _day;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.dayImage = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", self.day.number]];
	[self.imageButton setImage:self.dayImage forState:UIControlStateNormal];
	[self.imageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
	self.dateLabel.text = [self.day dateDescription];
	self.dayLabel.text = self.day.name;
	self.titleLabel.text = self.day.headline;
}

- (void)fetchDayByDate:(NSDate*)date {
	PFQuery *query = [PFQuery queryWithClassName:@"Day_de"];
	[query whereKey:@"date" equalTo:date];
	query.limit = 1;
	
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			// The find succeeded.
			NSLog(@"Successfully retrieved %lu entries", (unsigned long)objects.count);
			PFObject *object = objects.firstObject;
			
			NSLog(@"%@", object.objectId);
			
			Day *day = [[Day alloc] init];
			if(object) {
				day.date = object[@"date"];
				day.week_id = [object[@"week_id"] intValue];
				day.lit_day = object[@"lit_day"];
				day.title = object[@"title"];
				day.title_image = object[@"title_image"];
				day.bible_verse = object[@"bible_verse"];
				day.impulse = object[@"impulse"];
				day.image = object[@"image"];
				day.audio_link = object[@"audio_link"];
				day.audio_desc = object[@"audio_desc"];
				day.video_link = object[@"video_link"];
				day.video_desc = object[@"video_desc"];
				day.call_gospel = object[@"call_gospel"];
				day.verse_gospel = object[@"verse_gospel"];
				day.gospel = object[@"gospel"];
				day.reading_link = object[@"reading_link"];
				day.reading_desc = object[@"reading_desc"];
				
				if (self.dayCache) self.dayCache[day.date] = day;
				
				
				NSLog(@"Object added to cache: \"%@\"", day.title);
			}

		} else {
			// Log details of the failure
			NSLog(@"Error: %@ %@", error, [error userInfo]);
		}
	}];
	
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	ESDayContentController *controller = (ESDayContentController *)[segue destinationViewController];
	controller.day = self.day;
	
	if ([segue.identifier isEqualToString:@"Gospel"]) {
		controller.selectedViewController = controller.viewControllers[1];
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
