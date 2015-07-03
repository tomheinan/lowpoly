//
//  Triangle.m
//  LowPoly
//
//  Created by Tom Heinan on 7/3/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

#import "Triangle.h"

@implementation Triangle

- (instancetype)initWithA:(CGPoint)a b:(CGPoint)b c:(CGPoint)c
{
    if (self = [super init]) {
        self.a = a;
        self.b = b;
        self.c = c;
    }
    
    return self;
}

- (CGPathRef)path
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, self.a.x, self.a.y);
    CGPathAddLineToPoint(path, nil, self.b.x, self.b.y);
    CGPathAddLineToPoint(path, nil, self.c.x, self.c.y);
    CGPathCloseSubpath(path);
    
    return path;
}

@end

