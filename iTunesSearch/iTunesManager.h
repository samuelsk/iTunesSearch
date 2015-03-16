//
//  iTunesManager.h
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Midia.h"

@interface iTunesManager : NSObject

@property (strong, nonatomic) Midia *midia;
@property (strong, nonatomic) NSMutableArray *termos;

/**
 * gets singleton object.
 * @return singleton
 */
+ (iTunesManager*)sharedInstance;
- (NSArray *)buscarMidias:(NSString *)termo;

@end
