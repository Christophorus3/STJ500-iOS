//
//  ESDay.h
//  FastenKalender
//
//  Created by Christoph Wottawa on 20.02.14.
//  Copyright (c) 2014 Christoph Wottawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESDay : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic) int number;

- (NSString *)dateDescription;


@end
