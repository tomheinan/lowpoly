//
//  Delaunay.h
//  LowPoly
//
//  Created by Tom Heinan on 7/3/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface Delaunay : NSObject

+ (NSSet *)objc_triangulate:(NSSet *)values boundingRect:(CGRect)rect;

@end
NS_ASSUME_NONNULL_END
