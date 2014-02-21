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

@end

@implementation ESDayViewController

@synthesize imageButton = _imageButton;
@synthesize dateLabel = _dateLabel;
@synthesize dayLabel = _dayLabel;
@synthesize titleLabel = _titleLabel;

@synthesize dayImage = _dayImage;

@synthesize index = _index;

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
