//
//  Musica.m
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Musica.h"

@implementation Musica

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super initWithDictionary:dictionary];
    if (self) {
        [self setAlbum:[dictionary objectForKey:@"collectionName"]];
        [self setCollectionId:[dictionary objectForKey:@"collectionId"]];
        [self setPrecoAlbum:[dictionary objectForKey:@"collectionPrice"]];
        [self setDuracao:[dictionary objectForKey:@"trackTimeMillis"]];
    }
    return self;
}

@end
