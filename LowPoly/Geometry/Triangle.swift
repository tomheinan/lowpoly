//
//  Triangle.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/5/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

@objc public class Triangle: NSObject {
    
    public var a: CGPoint
    public var b: CGPoint
    public var c: CGPoint
    
    public var centroid: CGPoint {
        let x = (a.x + b.x + c.x) / 3.0
        let y = (a.y + b.y + c.y) / 3.0
        
        return CGPoint(x: x, y: y)
    }
    
    public var path: CGPath {
        var path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, a.x, a.y)
        CGPathAddLineToPoint(path, nil, b.x, b.y)
        CGPathAddLineToPoint(path, nil, c.x, c.y)
        CGPathCloseSubpath(path)
        
        return path
    }
    
    public init(a: CGPoint, b: CGPoint, c: CGPoint) {
        self.a = a
        self.b = b
        self.c = c
    }
    
}
