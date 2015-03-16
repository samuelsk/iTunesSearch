//
//  eBook.m
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "eBook.h"

@implementation eBook

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        [self setDescricao:[dictionary objectForKey:@"description"]];
        [self setAvaliacao:[dictionary objectForKey:@"averageUserRating"]];
        [self setGeneros:[dictionary objectForKey:@"genres"]];
    }
    return self;
}

@end
