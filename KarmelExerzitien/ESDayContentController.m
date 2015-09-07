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
	ESHTMLViewController *day = (ESHTMLViewController *)self.viewControllers[0];
	ESHTMLViewController *gospel = (ESHTMLViewController *)self.viewControllers[1];
	
	NSURL *dayURL = [[NSBundle mainBundle] URLForResource:@"day" withExtension:@"html"];
	NSURL *gospelURL = [[NSBundle mainBundle] URLForResource:@"evang" withExtension:@"html"];
	NSString *dayContent = [self buildContentStringForDay];
	NSString *gospelContent = [self buildContentStringForGospel];
	
	day.contentURL = dayURL;
	day.content = dayContent;
	gospel.contentURL = gospelURL;
	gospel.content = gospelContent;
	
}

- (NSString*)buildContentStringForDay {
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:@"day" withExtension:@"html"];
	NSString *templateString = [NSString stringWithContentsOfURL:contentURL usedEncoding:nil error:nil];
    
    NSString *result = [templateString stringByReplacingOccurrencesOfString:@"[dateString]" withString:self.day.dateDescription];
    
    NSString *audioString = @"<div class=\"audio\"><img src=\"teresa.jpg\"><p>[audio_desc]</p></div><audio controls><source src=\"[audio_ref]\" type=\"audio/mpeg\"></audio>";
    
    NSString *videoString = @"<div class=\"image\"><iframe width=\"320\" height=\"240\" src=\"http://www.youtube.com/embed/[video_ref]?showinfo=0\" frameborder=\"0\" allowfullscreen></iframe><a href=\"youtube:[video_ref]\">[video_desc]</a></div>";
	
    if(self.day.audio) {
        result = [result stringByReplacingOccurrencesOfString:@"[audio]" withString:audioString];
        result = [result stringByReplacingOccurrencesOfString:@"[audio_desc]" withString:self.day.audio_desc];
        result = [result stringByReplacingOccurrencesOfString:@"[audio_ref]" withString:[self.day.audio absoluteString]];
    } else {
        result = [result stringByReplacingOccurrencesOfString:@"[audio]" withString:@""];
    }
    
    if(self.day.video_ref) {
        result = [result stringByReplacingOccurrencesOfString:@"[video]" withString:videoString];
        result = [result stringByReplacingOccurrencesOfString:@"[video_desc]" withString:self.day.video_desc];
        result = [result stringByReplacingOccurrencesOfString:@"[video_ref]" withString:self.day.video_ref];
    } else {
        result = [result stringByReplacingOccurrencesOfString:@"[video]" withString:@""];
    }
	
	result = [result stringByReplacingOccurrencesOfString:@"[lit_name]" withString:self.day.lit_name];
	result = [result stringByReplacingOccurrencesOfString:@"[image]" withString:[self.day.image absoluteString]];
	result = [result stringByReplacingOccurrencesOfString:@"[teresa_text]" withString:self.day.teresa_text];
	result = [result stringByReplacingOccurrencesOfString:@"[teresa_ref]" withString:self.day.teresa_ref];
	return result;
}

- (NSString*)buildContentStringForGospel {
	NSURL *contentURL = [[NSBundle mainBundle] URLForResource:@"evang" withExtension:@"html"];
	NSString *templateString = [NSString stringWithContentsOfURL:contentURL usedEncoding:nil error:nil];
	
	//NSString *audioString = @"<div class=\"audio\"><img src=\"thost.jpg\"><p>[gospel_reader]</p></div><audio controls><source src=\"[gospel_audio]\" type=\"audio/mpeg\"></audio>";
	
	NSString *result = [templateString stringByReplacingOccurrencesOfString:@"[dateString]" withString:self.day.dateDescription];
	result = [result stringByReplacingOccurrencesOfString:@"[lit_name]" withString:self.day.lit_name];
	/*
    if(self.day.gospel_audio) {
		result = [result stringByReplacingOccurrencesOfString:@"[audio]" withString:audioString];
		result = [result stringByReplacingOccurrencesOfString:@"[gospel_reader]" withString:self.day.gospel_reader];
		result = [result stringByReplacingOccurrencesOfString:@"[gospel_audio]" withString:[self.day.gospel_audio absoluteString]];
	} else {
		result = [result stringByReplacingOccurrencesOfString:@"[audio]" withString:@""];
	}*/
	result = [result stringByReplacingOccurrencesOfString:@"[verse_gospel]" withString:self.day.bible_ref];
	result = [result stringByReplacingOccurrencesOfString:@"[gospel]" withString:self.day.bible_text];
	return result;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
