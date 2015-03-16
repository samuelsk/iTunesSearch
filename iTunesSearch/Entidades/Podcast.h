//
//  Podcast.h
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"

@interface Podcast : Midia

@property (nonatomic, strong) NSArray *generos;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
