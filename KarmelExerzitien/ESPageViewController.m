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

@end

@implementation ESPageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.days = [self createDayArray];
	_dayCache = [[NSMutableDictionary alloc] init];
	
	self.currentPage =  0; //[self currentDayPageNumber];
	
	self.dataSource = self;
	self.delegate = self;
	
	
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	comps.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
	comps.day = 1;
	comps.month = 12;
	comps.year = 2014;
	comps.hour = 0;
	comps.minute = 0;
	
	NSDate *day = [[NSCalendar currentCalendar] dateFromComponents:comps];
	
	[self fetchDayByDate:day];
	
	
	[self setViewControllers:@[[self viewControllerForPageNumber:self.currentPage]]
				   direction:UIPageViewControllerNavigationDirectionForward
					animated:YES
				  completion:nil];
	
	//[self setLocalNotifications];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	//return [self viewControllerForPageNumber:((ESDayViewController *) viewController).index + 1];
	return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	//return [self viewControllerForPageNumber:((ESDayViewController *) viewController).index - 1];
	return nil;
}

- (ESDayViewController *)viewControllerForDate:(NSDate *)date {
	
	return nil;
}

- (void)fetchDayByDate:(NSDate*)date {
	PFQuery *query = [PFQuery queryWithClassName:NSLocalizedString(@"Day_de", nil)];
	[query whereKey:@"date" equalTo:date];
	query.limit = 1;
	
	
	[query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
		if (!error) {
			// The find succeeded.
			NSLog(@"Successfully retrieved %lu entries", (unsigned long)objects.count);
			// Do something with the found objects
			for (PFObject *object in objects) {
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
					
					self.dayCache[day.date] = day;
					
					NSLog(@"Object added to cache: \"%@\"", day.title);
				}
				
			}
		} else {
			// Log details of the failure
			NSLog(@"Error: %@ %@", error, [error userInfo]);
		}
	}];
	
}


- (ESDayViewController *)viewControllerForPageNumber:(int)number
{
	if(number == self.days.count + 1) {
		NSDate *now = [NSDate date];
		
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		calendar.timeZone = [NSTimeZone systemTimeZone];
		
		//create StartDate:
		//Wann ist Osterdienstag?
		NSDateComponents *comps = [[NSDateComponents alloc] init];
		comps.timeZone = [NSTimeZone systemTimeZone];
		comps.day = 22;
		comps.month = 4;
		comps.year = 2014;
		comps.hour = 0;
		comps.minute = 0;
		
		NSDate *endDay = [calendar dateFromComponents:comps];
		
		if([endDay compare:now] == NSOrderedAscending) {
			ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Outro"];
			controller.index = number;
			return controller;
			
		} else return nil;
	}
	
	if(number < 0 || number > self.days.count) {
		return nil;
	} else if(number == 0) {
		ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Intro"];
		controller.index = number;
		
		return controller;
		
	} else {
		NSDate *now = [NSDate date];
		
		Day *day = self.days[number - 1];
		
		if([day.date compare:now] == NSOrderedAscending) {
			ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Day"];
			[controller setDay:self.days[number - 1]];
			controller.index = number;
			
			return controller;
		} else return nil;
	}
}

- (int)currentDayPageNumber
{
	NSDate *now = [NSDate date];
	
	int i = 0;
	
	for (Day *day in self.days) {
		if([day.date compare:now] == NSOrderedAscending) {
			i = MAX(i, day.number);
		}
	}
	Day *last = self.days.lastObject;
	if([last.date compare:now] == NSOrderedAscending) {
		return self.days.count + 1;
	}
	
	return i;
}

- (void)setLocalNotifications
{
	for (Day *day in self.days) {
		if([day.date compare:[NSDate date]] == NSOrderedDescending) {
			UILocalNotification *notification = [[UILocalNotification alloc] init];
			
			notification.fireDate = [day.date dateByAddingTimeInterval:60*60*10];
			notification.alertAction = @"Lesen";
			notification.alertBody = [@"KarmelExerzitien-Impuls für Heute: " stringByAppendingString:day.headline];
			notification.soundName = UILocalNotificationDefaultSoundName;
			notification.timeZone = [NSTimeZone localTimeZone];
			notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
			
			[[UIApplication sharedApplication] scheduleLocalNotification:notification];
		}
	}
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	calendar.timeZone = [NSTimeZone systemTimeZone];
	
	//create StartDate:
	//Wann ist Osterdienstag?
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	comps.timeZone = [NSTimeZone systemTimeZone];
	comps.day = 22;
	comps.month = 4;
	comps.year = 2014;
	comps.hour = 10;
	comps.minute = 0;
	
	NSDate *endDay = [calendar dateFromComponents:comps];
	
	UILocalNotification *notification = [[UILocalNotification alloc] init];
	
	notification.fireDate = endDay;
	notification.alertAction = @"Lesen";
	notification.alertBody = @"KarmelExerzitien Update für die Adventzeit";
	notification.soundName = UILocalNotificationDefaultSoundName;
	notification.timeZone = [NSTimeZone localTimeZone];
	notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
	
	[[UIApplication sharedApplication] scheduleLocalNotification:notification];
	
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

- (NSArray *)createDayArray {
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	calendar.timeZone = [NSTimeZone systemTimeZone];
	
	//create StartDate:
	//Wann beginnt die Fastenzeit?
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	comps.timeZone = [NSTimeZone systemTimeZone];
	comps.day = 5;
	comps.month = 3;
	comps.year = 2014;
	comps.hour = 0;
	comps.minute = 0;
	
	NSDate *startDay = [calendar dateFromComponents:comps];
	int startNumber = 1;
	
	//start building all the days: :-D
	
	Day *day1 = [Day new];
	day1.name = @"Aschermittwoch";
	day1.headline = @"Innere Umkehrbewegung";
	day1.number = startNumber++;
	day1.date = startDay;
	
	Day *day2 = [Day new];
	day2.name = @"";
	day2.headline = @"Weckruf von … Gott?…";
	day2.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day2.date = startDay;
	
	Day *day3 = [Day new];
	day3.name = @"";
	day3.headline = @"Höre mich und hilf mir!";
	day3.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day3.date = startDay;
	
	Day *day4 = [Day new];
	day4.name = @"";
	day4.headline = @"In Gottes Herzen";
	day4.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day4.date = startDay;
	
	Day *day5 = [Day new];
	day5.name = @"Erster Fastensonntag";
	day5.headline = @"Mir kann an keinem Ort der Welt etwas fehlen!";
	day5.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day5.date = startDay;
	
	Day *day6 = [Day new];
	day6.name = @"";
	day6.headline = @"Heilsame Sachlichkeit";
	day6.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day6.date = startDay;
	
	Day *day7 = [Day new];
	day7.name = @"";
	day7.headline = @"Jeder soll darauf achten, wie er weiterbaut.";
	day7.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day7.date = startDay;
	
	Day *day8 = [Day new];
	day8.name = @"";
	day8.headline = @"Das Bild des Herrn";
	day8.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day8.date = startDay;
	
	Day *day9 = [Day new];
	day9.name = @"";
	day9.headline = @"Eucharistie im Alltag";
	day9.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day9.date = startDay;
	
	Day *day10 = [Day new];
	day10.name = @"";
	day10.headline = @"Göttliche Barmherzigkeit";
	day10.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day10.date = startDay;
	
	Day *day11 = [Day new];
	day11.name = @"";
	day11.headline = @"Gottesbeziehung";
	day11.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day11.date = startDay;
	
	Day *day12 = [Day new];
	day12.name = @"Zweiter Fastensonntag";
	day12.headline = @"Sehnen und Suchen";
	day12.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day12.date = startDay;
	
	Day *day13 = [Day new];
	day13.name = @"";
	day13.headline = @"Ewigkeit und Zeit";
	day13.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day13.date = startDay;
	
	Day *day14 = [Day new];
	day14.name = @"";
	day14.headline = @"Meine Lebensregel?";
	day14.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day14.date = startDay;
	
	Day *day15 = [Day new];
	day15.name = @"Hl. Josef";
	day15.headline = @"Ich bin getauft…";
	day15.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day15.date = startDay;
	
	Day *day16 = [Day new];
	day16.name = @"";
	day16.headline = @"Sei besiegelt durch den Hl. Geist";
	day16.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day16.date = startDay;
	
	Day *day17 = [Day new];
	day17.name = @"";
	day17.headline = @"Zwischen Tiefe und Oberfläche";
	day17.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day17.date = startDay;
	
	Day *day18 = [Day new];
	day18.name = @"";
	day18.headline = @"Christsein im Alltag";
	day18.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day18.date = startDay;
	
	Day *day19 = [Day new];
	day19.name = @"Dritter Fastensonntag";
	day19.headline = @"Ausstrahlung";
	day19.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day19.date = startDay;
	
	Day *day20 = [Day new];
	day20.name = @"";
	day20.headline = @"Vorhöfe und Grenzen";
	day20.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day20.date = startDay;
	
	Day *day21 = [Day new];
	day21.name = @"Verkündigung des Herrn";
	day21.headline = @"Wenn Ihr fastet";
	day21.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day21.date = startDay;
	
	Day *day22 = [Day new];
	day22.name = @"";
	day22.headline = @"Im bergenden Arm";
	day22.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day22.date = startDay;
	
	Day *day23 = [Day new];
	day23.name = @"";
	day23.headline = @"Lebensquell";
	day23.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day23.date = startDay;
	
	Day *day24 = [Day new];
	day24.name = @"";
	day24.headline = @"Gott, Du allein";
	day24.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day24.date = startDay;
	
	Day *day25 = [Day new];
	day25.name = @"";
	day25.headline = @"Zeit – Krankheit";
	day25.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day25.date = startDay;
	
	Day *day26 = [Day new];
	day26.name = @"Vierter Fastensonntag";
	day26.headline = @"Auf dem Weg zur Quelle";
	day26.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day26.date = startDay;
	
	Day *day27 = [Day new];
	day27.name = @"";
	day27.headline = @"Ich bin durchaus keine Heilige...";
	day27.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day27.date = startDay;
	
	Day *day28 = [Day new];
	day28.name = @"";
	day28.headline = @"Die Gesegnete vom Kreuz";
	day28.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day28.date = startDay;
	
	Day *day29 = [Day new];
	day29.name = @"";
	day29.headline = @"Nahrung für die Seele";
	day29.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day29.date = startDay;
	
	Day *day30 = [Day new];
	day30.name = @"";
	day30.headline = @"Aug' in Aug' mit Gott";
	day30.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day30.date = startDay;
	
	Day *day31 = [Day new];
	day31.name = @"";
	day31.headline = @"zufrieden mit dem Balken im Auge?";
	day31.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day31.date = startDay;
	
	Day *day32 = [Day new];
	day32.name = @"";
	day32.headline = @"Boden unter den Füßen";
	day32.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day32.date = startDay;
	
	Day *day33 = [Day new];
	day33.name = @"Fünfter Fastensonntag";
	day33.headline = @"Du bist mein starker Gott";
	day33.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day33.date = startDay;
	
	Day *day34 = [Day new];
	day34.name = @"";
	day34.headline = @"Wege zur inneren Stille";
	day34.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day34.date = startDay;
	
	Day *day35 = [Day new];
	day35.name = @"";
	day35.headline = @"";
	day35.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day35.date = startDay;
	
	Day *day36 = [Day new];
	day36.name = @"";
	day36.headline = @"Bei Gott ist nichts unmöglich";
	day36.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day36.date = startDay;
	
	Day *day37 = [Day new];
	day37.name = @"";
	day37.headline = @"Ewige Liebe";
	day37.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day37.date = startDay;
	
	Day *day38 = [Day new];
	day38.name = @"";
	day38.headline = @"Ich muss immer wieder an die Königin Esther denken";
	day38.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day38.date = startDay;
	
	Day *day39 = [Day new];
	day39.name = @"";
	day39.headline = @"Wir lieben Gott und die Menschen mit ein und demselben Herzen";
	day39.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day39.date = startDay;
	
	Day *day40 = [Day new];
	day40.name = @"Palmsonntag";
	day40.headline = @"Hosanna!";
	day40.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day40.date = startDay;
	
	Day *day41 = [Day new];
	day41.name = @"";
	day41.headline = @"";
	day41.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day41.date = startDay;
	
	Day *day42 = [Day new];
	day42.name = @"";
	day42.headline = @"Leben für die Ewigkeit";
	day42.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day42.date = startDay;
	
	Day *day43 = [Day new];
	day43.name = @"";
	day43.headline = @"Hingabe an den Willen Gottes";
	day43.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day43.date = startDay;
	
	Day *day44 = [Day new];
	day44.name = @"Gründonnerstag";
	day44.headline = @"Im Kreuz ist Heil";
	day44.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day44.date = startDay;
	
	Day *day45 = [Day new];
	day45.name = @"Karfreitag";
	day45.headline = @"Im Kreuz ist Leben";
	day45.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day45.date = startDay;
	
	Day *day46 = [Day new];
	day46.name = @"Karsamstag";
	day46.headline = @"Neues Leben nach und nach";
	day46.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day46.date = startDay;
	
	Day *day47 = [Day new];
	day47.name = @"Ostersonntag";
	day47.headline = @"Strahlend jubelt die Natur dem Auferstandenen";
	day47.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day47.date = startDay;
	
	Day *day48 = [Day new];
	day48.name = @"Ostermontag";
	day48.headline = @"…und bliebe unser Herz brennend davon!";
	day48.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day48.date = startDay;
	
	return [NSArray arrayWithObjects:day1, day2, day3, day4, day5, day6, day7, day8, day9, day10, day11, day12,
			day13, day14, day15, day16, day17, day18, day19, day20, day21, day22, day23, day24, day25, day26,
			day27, day28, day29, day30, day31, day32, day33, day34, day35, day36, day37, day38, day39, day40,
			day41, day42, day43, day44, day45, day46, day47, day48, nil];
}

@end
