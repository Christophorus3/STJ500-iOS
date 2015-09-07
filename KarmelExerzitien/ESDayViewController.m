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

- (void)setDate:(NSDate *)date
{
    _date = date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _dateString = [dateFormatter stringFromDate:date];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dateLabel.text = [self.day dateDescription];
    //self.dayLabel.text = self.day.title;
    
    //isWeekLoaded = NO;
    //isDayLoaded = NO;
    
    self.imageButton.enabled = NO;
    
    
    //[self addObserver:self forKeyPath:@"day" options:0 context:nil];
    
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"KEDownloadDayNotification"
    //													object:self
    //												  userInfo:@{@"viewController":self,
    //															 @"date":self.dateString}];
    
    if(!self.day) {
        [self downloadData];
    }
    
}

- (void)downloadData
{
    //ESDayViewController *dayView = [notification userInfo][@"viewController"];
    //NSString *fetchDate = [notification userInfo][@"date"];
    
    
    //dayView.day = [persistencyManager getImage:[coverUrl lastPathComponent]];
    
    if(!self.day) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PFQuery *query = [PFQuery queryWithClassName:NSLocalizedString(@"Calendar", nil)];
            [query whereKey:@"date" equalTo:self.dateString];
            query.limit = 1;
            //query.cachePolicy = kPFCachePolicyCacheElseNetwork;
            
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
                
                
                if(object[@"audio"]) {
                    PFFile *audio = object[@"audio"];
                    day.audio = [NSURL URLWithString:[audio url]];
                    day.audio_desc = object[@"audio_desc"];
                }
                
                
                if(object[@"video_ref"]) {
                    day.video_ref = object[@"video_ref"];
                    day.video_desc = object[@"video_desc"];
                }
                
                PFQuery *query = [PFQuery queryWithClassName:@"Images"];
                [query whereKey:@"date" equalTo:self.dateString];
                //query.cachePolicy = kPFCachePolicyCacheElseNetwork;
                PFObject *imageObj = [query getFirstObject];
                if(imageObj) {
                    
                    PFFile *image = imageObj[@"image"];
                    day.image = [NSURL URLWithString:[image url]];
                    day.imageData = [image getData];
                    
                    self.day = day;
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self displayData];
                    });
                    
                }
                
            }
            
        });
    }
}

- (void)displayData {
    if (self.day) {
        self.dayImage = [UIImage imageWithData:self.day.imageData];
        [self.imageButton setImage:self.dayImage forState:UIControlStateNormal];
        [self.imageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        formatter.dateFormat = NSLocalizedString(@"dateFormat", nil);
        self.formattedDateString = [formatter stringFromDate:self.date];
        self.dateLabel.text = self.day.dateDescription;
        self.dayLabel.text = self.day.lit_name;
        self.textLabel.text = self.day.teresa_short;
        self.imageButton.enabled = YES;
        [self.spinner stopAnimating];
        self.spinnerCover.hidden = YES;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"day"]) {
        self.dayImage = [UIImage imageWithData:self.day.imageData];
        [self.imageButton setImage:self.dayImage forState:UIControlStateNormal];
        [self.imageButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
        self.textLabel.text = self.day.teresa_short;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setLocale:[NSLocale currentLocale]];
        formatter.dateFormat = NSLocalizedString(@"dateFormat", nil);
        self.formattedDateString = [formatter stringFromDate:self.date];
        self.dateLabel.text = self.day.dateDescription;
        self.imageButton.enabled = YES;
        [self.spinner stopAnimating];
        self.spinnerCover.hidden = YES;
    }
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ESDayContentController *controller = (ESDayContentController *)[segue destinationViewController];
    controller.day = self.day;
    controller.formattedDateString = self.formattedDateString;
    controller.selectedViewController = controller.viewControllers[0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    //[self removeObserver:self forKeyPath:@"day"];
}


@end
