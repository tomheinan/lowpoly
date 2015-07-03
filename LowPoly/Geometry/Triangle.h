//
//  Triangle.h
//  LowPoly
//
//  Created by Tom Heinan on 7/3/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface Triangle : NSObject

@property (nonatomic, assign) CGPoint a;
@property (nonatomic, assign) CGPoint b;
@property (nonatomic, assign) CGPoint c;

@property (nonatomic, assign, readonly) CGPathRef path;

- (instancetype)initWithA:(CGPoint)a b:(CGPoint)b c:(CGPoint)c NS_DESIGNATED_INITIALIZER;

@end
NS_ASSUME_NONNULL_END
