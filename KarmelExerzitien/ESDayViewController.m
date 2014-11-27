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
{
	BOOL isWeekLoaded;
	BOOL isDayLoaded;
}

@property (nonatomic, strong) UIImage *dayImage;
//@property (atomic, weak) NSArray *days;

@end

@implementation ESDayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	//self.dateLabel.text = [self.day dateDescription];
	self.dayLabel.text = self.day.name;
	
	isWeekLoaded = NO;
	isDayLoaded = NO;
	
	self.imageButton.enabled = NO;
	
	
	[self addObserver:self forKeyPath:@"day" options:0 context:nil];
	[self addObserver:self forKeyPath:@"week" options:0 context:nil];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"KEDownloadDayNotification"
														object:self
													  userInfo:@{@"viewController":self,
																 @"date":self.date}];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if ([keyPath isEqualToString:@"day"]) {
		//[self.spinner stopAnimating];
		
		isDayLoaded = YES;
		//self.spinnerCover.hidden = YES;
	}
	
	if ([keyPath isEqualToString:@"week"]) {
		isWeekLoaded = YES;
	}
	
	if(isWeekLoaded && isDayLoaded) {
		self.dayImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.day.title_image]];
		[self.imageButton setImage:self.dayImage forState:UIControlStateNormal];
		[self.imageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
		self.titleLabel.text = self.day.title;
		NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
		[formatter setLocale:[NSLocale currentLocale]];
		formatter.dateFormat = NSLocalizedString(@"dateFormat", nil);
		self.dateString = [formatter stringFromDate:self.date];
		self.dateLabel.text = self.dateString;
		self.imageButton.enabled = YES;
		[self.spinner stopAnimating];
		self.spinnerCover.hidden = YES;
	}
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	ESDayContentController *controller = (ESDayContentController *)[segue destinationViewController];
	controller.day = self.day;
	controller.week = self.week;
	controller.dateString = self.dateString;
	controller.selectedViewController = controller.viewControllers[1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
	[self removeObserver:self forKeyPath:@"day"];
	[self removeObserver:self forKeyPath:@"week"];
}


@end
