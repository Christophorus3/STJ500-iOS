//
//  ESPageViewController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESPageViewController.h"
#import "ESDayViewController.h"
#import "Day.h"

@interface ESPageViewController ()
{
	NSDate *begin;
	NSDate *end;
	NSDate *now;
	NSDateComponents *minusOneDay;
	NSDateComponents *plusOneDay;
}

@end

@implementation ESPageViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	//Init content Kit:
	[KEContentKit sharedInstance];
	
	//_dayCache = [[NSMutableDictionary alloc] init];
	
	NSDateComponents *compsBegin = [[NSDateComponents alloc] init];
	//compsBegin.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	compsBegin.timeZone = [NSTimeZone localTimeZone];
	compsBegin.day = 30;
	compsBegin.month = 11;
	compsBegin.year = 2014;
	compsBegin.hour = 0;
	compsBegin.minute = 0;
	
	begin = [[NSCalendar currentCalendar] dateFromComponents:compsBegin];
	
	NSDateComponents *compsEnd = [[NSDateComponents alloc] init];
	//compsEnd.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	compsEnd.timeZone = [NSTimeZone localTimeZone];
	compsEnd.day = 24;
	compsEnd.month = 12;
	compsEnd.year = 2014;
	compsEnd.hour = 0;
	compsEnd.minute = 0;
	
	end = [[NSCalendar currentCalendar] dateFromComponents:compsEnd];
	
	minusOneDay = [[NSDateComponents alloc] init];
	minusOneDay.day = -1;
	
	plusOneDay = [[NSDateComponents alloc] init];
	plusOneDay.day = 1;
	
	//self.currentPage =  0; //[self currentDayPageNumber];
	
	self.dataSource = self;
	self.delegate = self;
	
	now = [NSDate date];
	
	[self setViewControllers:@[[self viewControllerForDate:now]]
				   direction:UIPageViewControllerNavigationDirectionForward
					animated:NO
				  completion:nil];
	
	
	[self setLocalNotifications];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	NSDate *thisDay = ((ESDayViewController *)viewController).date;
	NSDate *compDay = [[NSCalendar currentCalendar] dateByAddingComponents:plusOneDay toDate:thisDay options:0];
	
	if([now compare:compDay] == NSOrderedAscending) {
		return nil;
	}
	
	if([end compare:thisDay] == NSOrderedAscending) {
		return nil;
	}
	
	NSDate *nextDay = [[NSCalendar currentCalendar] dateByAddingComponents:plusOneDay toDate:thisDay options:0];
	return [self viewControllerForDate:nextDay];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	NSDate *thisDay = ((ESDayViewController *)viewController).date;
	
	if([begin compare:thisDay] == NSOrderedDescending) {
		return nil;
	}
	NSDate *prevDay = [[NSCalendar currentCalendar] dateByAddingComponents:minusOneDay toDate:thisDay options:0];
	
	return [self viewControllerForDate:prevDay];
}

- (ESDayViewController *)viewControllerForDate:(NSDate *)date {
	
	NSDateComponents *components = [[NSCalendar currentCalendar]
									components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
									fromDate:date];
	NSDate *flatDate = [[NSCalendar currentCalendar]
						dateFromComponents:components];
	
	if([begin compare:flatDate] == NSOrderedDescending) {
		ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Intro"];
		controller.date = [[NSCalendar currentCalendar] dateByAddingComponents:minusOneDay toDate:begin options:0];
		return controller;
	} else if([end compare:flatDate] == NSOrderedAscending) {
		ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Outro"];
		controller.date = [[NSCalendar currentCalendar] dateByAddingComponents:plusOneDay toDate:end options:0];
		return controller;
	} else {
		ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Day"];
		controller.date = flatDate;
		return controller;
	}
	
	return nil;
}


- (void)setLocalNotifications
{
	[[UIApplication sharedApplication] cancelAllLocalNotifications];
	
	NSDateComponents *components = [[NSCalendar currentCalendar]
									components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
									fromDate:now];
	NSDate *flatNow = [[NSCalendar currentCalendar]
						dateFromComponents:components];
	
	NSDateComponents *alarmTime = [[NSDateComponents alloc] init];
	alarmTime.hour = 10;
	alarmTime.minute = 0;
	
	NSDate *date;
	
	int numberOfDays = [self daysBetweenDate:flatNow andDate:end];
	if (numberOfDays >= 24) {
		numberOfDays = 24;
		date = [[NSCalendar currentCalendar] dateByAddingComponents:alarmTime toDate:begin options:0];
	} else {
		date = [[NSCalendar currentCalendar] dateByAddingComponents:alarmTime toDate:flatNow options:0];
	}
	
	for (int i = 0; i < numberOfDays; i++) {
		
		date = [[NSCalendar currentCalendar] dateByAddingComponents:plusOneDay toDate:date options:0];
		
		UILocalNotification *notification = [[UILocalNotification alloc] init];
		
		notification.fireDate = date;
		notification.alertAction = NSLocalizedString(@"Lesen", nil);
		notification.alertBody = NSLocalizedString(@"KarmelExerzitien-Impuls für Heute verfügbar.", nil);
		notification.soundName = UILocalNotificationDefaultSoundName;
		notification.timeZone = [NSTimeZone localTimeZone];
		notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
		
		[[UIApplication sharedApplication] scheduleLocalNotification:notification];
	}
}

- (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
	
    NSCalendar *calendar = [NSCalendar currentCalendar];
	
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&fromDate
				 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSDayCalendarUnit startDate:&toDate
				 interval:NULL forDate:toDateTime];
	
    NSDateComponents *difference = [calendar components:NSDayCalendarUnit
											   fromDate:fromDate toDate:toDate options:0];
	
    return [difference day];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)date:(NSDate*)date1 isSameDayAsDate:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
	
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
	
    return [comp1 day]   == [comp2 day] &&
	[comp1 month] == [comp2 month] &&
	[comp1 year]  == [comp2 year];
}
@end
