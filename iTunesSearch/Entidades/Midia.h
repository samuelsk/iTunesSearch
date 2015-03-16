//
//  Midia.h
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Midia : NSObject

@property (nonatomic, strong) NSString *nome;
@property (nonatomic, strong) NSString *trackId;
@property (nonatomic, strong) NSString *artista;
@property (nonatomic, strong) NSString *genero;
@property (nonatomic, strong) NSString *pais;
@property (nonatomic, strong) NSString *preco;
@property (nonatomic, strong) NSDate *dataLanc;
@property (nonatomic, strong) NSString *imagem;
@property (nonatomic, strong) NSString *imagemHD;
@property (nonatomic, strong) NSString *link;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
