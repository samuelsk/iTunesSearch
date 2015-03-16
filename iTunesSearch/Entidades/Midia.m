//
//  Midia.m
//  iTunesSearch
//
//  Created by Samuel Shin Kim on 13/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "Midia.h"

@implementation Midia

- (instancetype)initWithDictionary:(NSDictionary *)result {
    self = [super init];
    if (self) {
        [self setNome:[result objectForKey:@"trackName"]];
        [self setTrackId:[result objectForKey:@"trackId"]];
        [self setArtista:[result objectForKey:@"artistName"]];
        [self setGenero:[result objectForKey:@"primaryGenreName"]];
        [self setPais:[result objectForKey:@"country"]];
        [self setPreco:[result objectForKey:@"trackPrice"]];
        [self setDataLanc:[result objectForKey:@"releaseDate"]];
        [self setImagem:[result objectForKey:@"artworkUrl60"]];
        [self setImagemHD:[result objectForKey:@"artworkUrl100"]];
        [self setLink:[result objectForKey:@"trackViewUrl"]];
    }
    return self;
}

//@implementar conversão de NSDate para formato correto (i.e. dd/MM/yyyy).
//- (NSString *)getDataLanc {
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
//    return [dateFormatter stringFromDate:self.dataLanc];
//}

@end
