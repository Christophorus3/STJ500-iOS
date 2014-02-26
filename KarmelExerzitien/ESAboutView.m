//
//  ESAboutView.m
//  FastenKalender
//
//  Created by Christoph Wottawa on 21.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import "ESAboutView.h"

@implementation ESAboutView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AboutView" owner:self options:nil];
		
		self = [nib objectAtIndex:0];
    }
    return self;
}


@end
