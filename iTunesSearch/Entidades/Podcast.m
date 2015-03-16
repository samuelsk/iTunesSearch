//
//  Podcast.m
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Podcast.h"

@implementation Podcast

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        [self setGeneros:[dictionary objectForKey:@"genres"]];
    }
    return self;
}

@end
