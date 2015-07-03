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
        if fabs(end.x - start.x) > CGFloat.epsilon {
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
    
    init(start: CGPoint, end: CGPoint) {
        if start.x > end.x {
            self.start = end
            self.end = start
        } else {
            self.start = start
            self.end = end
        }
    }
    
    // MARK: Hashable
    var hashValue: Int {
        return start.hashValue ^ end.hashValue
    }
    
    // MARK: Printable
    
    var description: String {
        return "<Edge: start = \(start); end = \(end)>"
    }
    
}

// MARK: Equatable

func ==(lhs: Edge, rhs: Edge) -> Bool {
    return (lhs.start == rhs.start && lhs.end == rhs.end) || (lhs.start == rhs.end && lhs.end == rhs.start)
}
