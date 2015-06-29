//
//  Line.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import CoreGraphics

struct Edge: Equatable, Hashable, Printable {
    
    // MARK: Properties
    
    var start: CGPoint
    var end: CGPoint
    
    var length: CGFloat {
        return sqrt(pow(end.x - start.x, 2) + pow(end.y - start.y, 2))
    }
    
    var slope: CGFloat? {
        // TODO: For some reason, Xcode won't compile this if it's defined on a CGFloat extension,
        // so that's why it's here instead
        #if CGFLOAT_IS_DOUBLE
            let CGFLOAT_EPSILON = CGFloat(DBL_EPSILON)
        #else
            let CGFLOAT_EPSILON = CGFloat(FLT_EPSILON)
        #endif
        
        if fabs(end.x - start.x) > CGFLOAT_EPSILON {
            return (end.y - start.y) / (end.x - start.x)
        } else {
            return nil
        }
    }
    
    var yIntercept: CGPoint? {
        if let m = slope {
            let b = (-1 * m * start.x) + start.y
            return CGPointMake(b, 0)
        } else {
            return nil
        }
    }
    
    var midpoint: CGPoint {
        let x = (start.x + end.x) * 0.5
        let y = (start.y + end.y) * 0.5
        
        return CGPointMake(x, y)
    }
    
    // MARK: Hashable
    var hashValue: Int {
        let x = start.x + end.x
        let y = start.y + end.y
        let sum = Float(x + y)
        return sum.hashValue
    }
    
    // MARK: Printable
    
    var description: String {
        return "<Edge: start = \(start); end = \(end); length = \(length); slope = \(slope); yIntercept = \(yIntercept); midpoint = \(midpoint)>"
    }
    
}

// MARK: Equatable

func ==(lhs: Edge, rhs: Edge) -> Bool {
    return (CGPointEqualToPoint(lhs.start, rhs.start) && CGPointEqualToPoint(lhs.end, rhs.end)) || (CGPointEqualToPoint(lhs.start, rhs.end) && CGPointEqualToPoint(lhs.end, rhs.start))
}
