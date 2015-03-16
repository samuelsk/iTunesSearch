//
//  Filme.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Filme.h"

@implementation Filme

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self ) {
        [self setDescricao:[dictionary objectForKey:@"longDescription"]];
        [self setClassIndic:[dictionary objectForKey:@"contentAdvisoryRating"]];
        [self setPrecoHD:[dictionary objectForKey:@"trackHDPrice"]];
        [self setDuracao:[dictionary objectForKey:@"trackTimeMillis"]];
    }
    return self;
}

@end
