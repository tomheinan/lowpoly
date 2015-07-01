//
//  Circumcircle.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import CoreGraphics

struct Circle: Equatable, Printable {
    
    var center: CGPoint
    var radius: CGFloat
    
    var path: CGPath {
        let rect = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2)
        return CGPathCreateWithEllipseInRect(rect, nil)
    }
    
    func contains(point: CGPoint) -> Bool {
        let a = point.x - center.x
        let b = point.y - center.y
        let c = radius
        
        return (a * a) + (b * b) <= (c * c)
    }
    
    // MARK: Printable
    
    var description: String {
        return "<Circle: center = \(center); radius = \(radius)>"
    }
    
}

// MARK: Equatable

func ==(lhs: Circle, rhs: Circle) -> Bool {
    return CGPointEqualToPoint(lhs.center, rhs.center) && fabs(lhs.radius - rhs.radius) < CGFloat.epsilon
}
