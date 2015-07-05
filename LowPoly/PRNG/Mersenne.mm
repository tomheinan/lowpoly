//
//  Mersenne.m
//  LowPoly
//
//  Created by Tom Heinan on 7/5/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

#import "Mersenne.h"
#import <random>

@implementation Mersenne

+ (NSArray *)objc_rands:(NSInteger)seed count:(NSInteger)count
{
    #ifdef __LP64__
    std::mt19937_64 engine(seed);
    #else
    std::mt19937 engine(seed);
    #endif
    
    std::uniform_real_distribution<> dist;
    NSMutableArray *rands = [[NSMutableArray alloc] initWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        double rand = dist(engine);
        [rands addObject:[NSNumber numberWithDouble:rand]];
    }
    
    return rands;
}


@end
