//
//  Musica.h
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 10/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"

@interface Musica : Midia

@property (nonatomic, strong) NSString *album;
@property (nonatomic, strong) NSString *collectionId;
@property (nonatomic, strong) NSString *precoAlbum;
@property (nonatomic, strong) NSString *duracao;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
