//
//  ESDayContentController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESDayContentController.h"
#import "ESHTMLViewController.h"

@interface ESDayContentController ()

@end

@implementation ESDayContentController

- (void)viewDidLoad
{
    [super viewDidLoad];
	//Add an About Button to the NavBar
	//UIButton *aboutButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	//self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aboutButton];
	//[aboutButton addTarget:self action:@selector(showAbout:) forControlEvents:UIControlEventTouchUpInside];
	
	// Prepare the two content Controllers
	ESHTMLViewController *week = (ESHTMLViewController *)self.viewControllers[0];
	ESHTMLViewController *day = (ESHTMLViewController *)self.viewControllers[1];
	ESHTMLViewController *gospel = (ESHTMLViewController *)self.viewControllers[2];
	
	//impuls.title = @"Impuls";
	//evangelium.title = @"Evangelium";
	
	NSURL *weekURL = [[NSBundle mainBundle] URLForResource:@"week" withExtension:@"html"];
	NSURL *dayURL = [[NSBundle mainBundle] URLForResource:@"day" withExtension:@"html"];
	NSURL *gospelURL = [[NSBundle mainBundle] URLForResource:@"evang" withExtension:@"html"];
	NSString *weekContent = [self buildContentStringForWeek];
	NSString *dayContent = [self buildContentStringForDay];
	NSString *gospelContent = [self buildContentStringForGospel];
	
	week.contentURL = weekURL;
	week.content = weekContent;
	day.contentURL = dayURL;
	day.content = dayContent;
	gospel.contentURL = gospelURL;
	gospel.content = gospelContent;
	
}

- (NSString*)buildContentStringForWeek {
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:@"week" withExtension:@"html"];
	NSString *templateString = [NSString stringWithContentsOfURL:contentURL usedEncoding:nil error:nil];
	NSString *result = [templateString stringByReplacingOccurrencesOfString:@"[week_title]" withString:self.week.week_title];
	
	result = [result stringByReplacingOccurrencesOfString:@"[impulse_title]" withString:self.week.impulse_title];
	result = [result stringByReplacingOccurrencesOfString:@"[image]" withString:[self.week.image absoluteString]];
	result = [result stringByReplacingOccurrencesOfString:@"[impulse]" withString:self.week.impulse];
	result = [result stringByReplacingOccurrencesOfString:@"[part1_title]" withString:self.week.part1_title];
	result = [result stringByReplacingOccurrencesOfString:@"[part1]" withString:self.week.part1];
	result = [result stringByReplacingOccurrencesOfString:@"[part2_title]" withString:self.week.part2_title];
	result = [result stringByReplacingOccurrencesOfString:@"[part2]" withString:self.week.part2];
	result = [result stringByReplacingOccurrencesOfString:@"[part3_title]" withString:self.week.part3_title];
	result = [result stringByReplacingOccurrencesOfString:@"[part3]" withString:self.week.part3];
	result = [result stringByReplacingOccurrencesOfString:@"[finale]" withString:self.week.finale];
	
	return result;
}

- (NSString*)buildContentStringForDay {
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:@"day" withExtension:@"html"];
	NSString *templateString = [NSString stringWithContentsOfURL:contentURL usedEncoding:nil error:nil];
	
	NSString *result = [templateString stringByReplacingOccurrencesOfString:@"[dateString]" withString:self.dateString];
	result = [result stringByReplacingOccurrencesOfString:@"[title]" withString:self.day.title];
	result = [result stringByReplacingOccurrencesOfString:@"[title_image]" withString:[self.day.title_image absoluteString]];
	result = [result stringByReplacingOccurrencesOfString:@"[bible_verse]" withString:self.day.bible_verse];
	result = [result stringByReplacingOccurrencesOfString:@"[impulse]" withString:self.day.impulse];
	return result;
}

- (NSString*)buildContentStringForGospel {
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:@"evang" withExtension:@"html"];
	NSString *templateString = [NSString stringWithContentsOfURL:contentURL usedEncoding:nil error:nil];
	
	NSString *audioString = @"<div class=\"audio\"><img src=\"thost.jpg\"><p>[gospel_reader]</p></div><audio controls><source src=\"[gospel_audio]\" type=\"audio/mpeg\"></audio>";
	
	NSString *result = [templateString stringByReplacingOccurrencesOfString:@"[dateString]" withString:self.dateString];
	result = [result stringByReplacingOccurrencesOfString:@"[title]" withString:self.day.title];
	result = [result stringByReplacingOccurrencesOfString:@"[lit_day]" withString:self.day.lit_day];
	if(self.day.gospel_audio) {
		result = [result stringByReplacingOccurrencesOfString:@"[audio]" withString:audioString];
		result = [result stringByReplacingOccurrencesOfString:@"[gospel_reader]" withString:self.day.gospel_reader];
		result = [result stringByReplacingOccurrencesOfString:@"[gospel_audio]" withString:[self.day.gospel_audio absoluteString]];
	} else {
		result = [result stringByReplacingOccurrencesOfString:@"[audio]" withString:@""];
	}
	result = [result stringByReplacingOccurrencesOfString:@"[verse_gospel]" withString:self.day.verse_gospel];
	result = [result stringByReplacingOccurrencesOfString:@"[gospel]" withString:self.day.gospel];
	return result;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
