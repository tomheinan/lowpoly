//
//  Mersenne.h
//  LowPoly
//
//  Created by Tom Heinan on 7/5/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface Mersenne : NSObject

+ (NSArray *)objc_rands:(NSInteger)seed count:(NSInteger)count;

@end
NS_ASSUME_NONNULL_END
