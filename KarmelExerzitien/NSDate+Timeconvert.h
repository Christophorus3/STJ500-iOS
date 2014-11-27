//
//  NSDate+Timeconvert.h
//  KarmelExerzitien
//
//  Created by Christoph Wottawa on 18.11.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Timeconvert)

-(NSDate *) toLocalTime;
-(NSDate *) toGlobalTime;

@end
