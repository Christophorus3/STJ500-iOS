//
//  ESPageViewController.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 07.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESPageViewController.h"
#import "ESDayViewController.h"
#import "ESDay.h"

@interface ESPageViewController ()

- (ESDayViewController *)viewControllerForPageNumber:(int)number;

@end

@implementation ESPageViewController

@synthesize days = _days;
@synthesize currentPage = _currentPage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.days = [self createDayArray];
	
	self.currentPage = 0;
	
	self.dataSource = self;
	self.delegate = self;
	
	[self setViewControllers:@[[self viewControllerForPageNumber:self.currentPage]]
				   direction:UIPageViewControllerNavigationDirectionForward
					animated:YES
				  completion:nil];
	/*
	UILocalNotification *notification = [[UILocalNotification alloc] init];
	
	notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:20];
	notification.alertAction = @"Lesen!";
	notification.alertBody = @"Neuer Impuls für den heutigen Tag der KarmelExerzitien!";
	notification.soundName = UILocalNotificationDefaultSoundName;
	notification.timeZone = [NSTimeZone localTimeZone];
	notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
	
	
	[[UIApplication sharedApplication] scheduleLocalNotification:notification];
	*/
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
	return [self viewControllerForPageNumber:((ESDayViewController *) viewController).index + 1];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
	return [self viewControllerForPageNumber:((ESDayViewController *) viewController).index - 1];
}

- (ESDayViewController *)viewControllerForPageNumber:(int)number
{
	if(number < 0 || number > self.days.count) {
		return nil;
	} else if(number == 0) {
		ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Intro"];
		controller.index = number;
		
		return controller;
		
	} else {
		NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
		calendar.timeZone = [NSTimeZone systemTimeZone];
		
		//create a reference date:
		NSDateComponents *comps = [[NSDateComponents alloc] init];
		comps.timeZone = [NSTimeZone systemTimeZone];
		comps.day = 21;
		comps.month = 4;
		comps.year = 2014;
		comps.hour = 11;
		
		NSDate *now = [calendar dateFromComponents:comps];
		
		ESDay *day = self.days[number - 1];
		
		if([day.date compare:now] == NSOrderedAscending) {
			ESDayViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"Day"];
			[controller setDay:self.days[number - 1]];
			controller.index = number;
			
			return controller;
		} else return nil;
	}
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)createDayArray {
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	calendar.timeZone = [NSTimeZone systemTimeZone];
	
	//create StartDate:
	NSDateComponents *comps = [[NSDateComponents alloc] init];
	comps.timeZone = [NSTimeZone systemTimeZone];
	comps.day = 5;
	comps.month = 3;
	comps.year = 2014;
	comps.hour = 10;
	
	NSDate *startDay = [calendar dateFromComponents:comps];
	int startNumber = 1;
	
	//start building all the days: :-D
	
	ESDay *day1 = [ESDay new];
	day1.name = @"Aschermittwoch";
	day1.headline = @"Innere Umkehrbewegung";
	day1.number = startNumber++;
	day1.date = startDay;
	
	ESDay *day2 = [ESDay new];
	day2.name = @"";
	day2.headline = @"Weckruf von … Gott?…";
	day2.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day2.date = startDay;
	
	ESDay *day3 = [ESDay new];
	day3.name = @"";
	day3.headline = @"Höre mich und hilf mir!";
	day3.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day3.date = startDay;
	
	ESDay *day4 = [ESDay new];
	day4.name = @"";
	day4.headline = @"In Gottes Herzen";
	day4.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day4.date = startDay;
	
	ESDay *day5 = [ESDay new];
	day5.name = @"Erster Fastensonntag";
	day5.headline = @"Mir kann an keinem Ort der Welt etwas fehlen!";
	day5.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day5.date = startDay;
	
	ESDay *day6 = [ESDay new];
	day6.name = @"";
	day6.headline = @"Heilsame Sachlichkeit";
	day6.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day6.date = startDay;
	
	ESDay *day7 = [ESDay new];
	day7.name = @"";
	day7.headline = @"Jeder soll darauf achten, wie er weiterbaut.";
	day7.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day7.date = startDay;
	
	ESDay *day8 = [ESDay new];
	day8.name = @"";
	day8.headline = @"Das Bild des Herrn";
	day8.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day8.date = startDay;
	
	ESDay *day9 = [ESDay new];
	day9.name = @"";
	day9.headline = @"Eucharistie im Alltag";
	day9.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day9.date = startDay;
	
	ESDay *day10 = [ESDay new];
	day10.name = @"";
	day10.headline = @"Göttliche Barmherzigkeit";
	day10.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day10.date = startDay;
	
	ESDay *day11 = [ESDay new];
	day11.name = @"";
	day11.headline = @"Gottesbeziehung";
	day11.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day11.date = startDay;
	
	ESDay *day12 = [ESDay new];
	day12.name = @"Zweiter Fastensonntag";
	day12.headline = @"Sehnen und Suchen";
	day12.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day12.date = startDay;
	
	ESDay *day13 = [ESDay new];
	day13.name = @"";
	day13.headline = @"Ewigkeit und Zeit";
	day13.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day13.date = startDay;
	
	ESDay *day14 = [ESDay new];
	day14.name = @"";
	day14.headline = @"Meine Lebensregel?";
	day14.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day14.date = startDay;
	
	ESDay *day15 = [ESDay new];
	day15.name = @"Hl. Josef";
	day15.headline = @"Ich bin getauft…";
	day15.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day15.date = startDay;
	
	ESDay *day16 = [ESDay new];
	day16.name = @"";
	day16.headline = @"Sei besiegelt durch den Hl. Geist";
	day16.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day16.date = startDay;
	
	ESDay *day17 = [ESDay new];
	day17.name = @"";
	day17.headline = @"Zwischen Tiefe und Oberfläche";
	day17.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day17.date = startDay;
	
	ESDay *day18 = [ESDay new];
	day18.name = @"";
	day18.headline = @"Christsein im Alltag";
	day18.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day18.date = startDay;
	
	ESDay *day19 = [ESDay new];
	day19.name = @"Dritter Fastensonntag";
	day19.headline = @"Ausstrahlung";
	day19.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day19.date = startDay;
	
	ESDay *day20 = [ESDay new];
	day20.name = @"";
	day20.headline = @"Vorhöfe und Grenzen";
	day20.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day20.date = startDay;
	
	ESDay *day21 = [ESDay new];
	day21.name = @"Verkündigung des Herrn";
	day21.headline = @"Wenn Ihr fastet";
	day21.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day21.date = startDay;
	
	ESDay *day22 = [ESDay new];
	day22.name = @"";
	day22.headline = @"Im bergenden Arm";
	day22.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day22.date = startDay;
	
	ESDay *day23 = [ESDay new];
	day23.name = @"";
	day23.headline = @"Lebensquell";
	day23.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day23.date = startDay;
	
	ESDay *day24 = [ESDay new];
	day24.name = @"";
	day24.headline = @"Gott, Du allein";
	day24.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day24.date = startDay;
	
	ESDay *day25 = [ESDay new];
	day25.name = @"";
	day25.headline = @"Zeit – Krankheit";
	day25.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day25.date = startDay;
	
	ESDay *day26 = [ESDay new];
	day26.name = @"Vierter Fastensonntag";
	day26.headline = @"Auf dem Weg zur Quelle";
	day26.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day26.date = startDay;
	
	ESDay *day27 = [ESDay new];
	day27.name = @"";
	day27.headline = @"Ich bin durchaus keine Heilige...";
	day27.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day27.date = startDay;
	
	ESDay *day28 = [ESDay new];
	day28.name = @"";
	day28.headline = @"Die Gesegnete vom Kreuz";
	day28.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day28.date = startDay;
	
	ESDay *day29 = [ESDay new];
	day29.name = @"";
	day29.headline = @"Nahrung für die Seele";
	day29.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day29.date = startDay;
	
	ESDay *day30 = [ESDay new];
	day30.name = @"";
	day30.headline = @"Aug' in Aug' mit Gott";
	day30.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day30.date = startDay;
	
	ESDay *day31 = [ESDay new];
	day31.name = @"";
	day31.headline = @"zufrieden mit dem Balken im Auge?";
	day31.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day31.date = startDay;
	
	ESDay *day32 = [ESDay new];
	day32.name = @"";
	day32.headline = @"Boden unter den Füßen";
	day32.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day32.date = startDay;
	
	ESDay *day33 = [ESDay new];
	day33.name = @"Fünfter Fastensonntag";
	day33.headline = @"Du bist mein starker Gott";
	day33.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day33.date = startDay;
	
	ESDay *day34 = [ESDay new];
	day34.name = @"";
	day34.headline = @"Wege zur inneren Stille";
	day34.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day34.date = startDay;
	
	ESDay *day35 = [ESDay new];
	day35.name = @"";
	day35.headline = @"Bei Gott ist nichts unmöglich";
	day35.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day35.date = startDay;
	
	ESDay *day36 = [ESDay new];
	day36.name = @"";
	day36.headline = @"Bei Gott ist nichts unmöglich";
	day36.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day36.date = startDay;
	
	ESDay *day37 = [ESDay new];
	day37.name = @"";
	day37.headline = @"Ewige Liebe";
	day37.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day37.date = startDay;
	
	ESDay *day38 = [ESDay new];
	day38.name = @"";
	day38.headline = @"Ich muss immer wieder an die Königin Esther denken";
	day38.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day38.date = startDay;
	
	ESDay *day39 = [ESDay new];
	day39.name = @"";
	day39.headline = @"Wir lieben Gott und die Menschen mit ein und demselben Herzen";
	day39.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day39.date = startDay;
	
	ESDay *day40 = [ESDay new];
	day40.name = @"Palmsonntag";
	day40.headline = @"Glauben und Lieben";
	day40.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day40.date = startDay;
	
	ESDay *day41 = [ESDay new];
	day41.name = @"";
	day41.headline = @"Leben für die Ewigkeit";
	day41.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day41.date = startDay;
	
	ESDay *day42 = [ESDay new];
	day42.name = @"";
	day42.headline = @"Leben für die Ewigkeit";
	day42.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day42.date = startDay;
	
	ESDay *day43 = [ESDay new];
	day43.name = @"";
	day43.headline = @"Hingabe an den Willen Gottes";
	day43.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day43.date = startDay;
	
	ESDay *day44 = [ESDay new];
	day44.name = @"Gründonnerstag";
	day44.headline = @"Kraft der Ölbergstunde";
	day44.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day44.date = startDay;
	
	ESDay *day45 = [ESDay new];
	day45.name = @"Karfreitag";
	day45.headline = @"Im Kreuz ist Leben";
	day45.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day45.date = startDay;
	
	ESDay *day46 = [ESDay new];
	day46.name = @"Karsamstag";
	day46.headline = @"Neues Leben nach und nach";
	day46.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day46.date = startDay;
	
	ESDay *day47 = [ESDay new];
	day47.name = @"Ostersonntag";
	day47.headline = @"Strahlend jubelt die Natur dem Auferstandenen";
	day47.number = startNumber++;
	startDay = [startDay dateByAddingTimeInterval:60*60*24*1];
	day47.date = startDay;
	
	ESDay *day48 = [ESDay new];
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
