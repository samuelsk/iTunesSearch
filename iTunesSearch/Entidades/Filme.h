//
//  Filme.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"

@interface Filme : Midia

@property (nonatomic, strong) NSString *descricao;
@property (nonatomic, strong) NSString *classIndic;
@property (nonatomic, strong) NSString *precoHD;
@property (nonatomic, strong) NSString *duracao;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
