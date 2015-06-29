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
    
    var bezierPath: UIBezierPath {
        let rect = CGRectMake(center.x - radius, center.y - radius, radius * 2, radius * 2)
        return UIBezierPath(ovalInRect: rect)
    }
    
    // MARK: Printable
    
    var description: String {
        return "<Circle: center = \(center); radius = \(radius)>"
    }
    
}

// MARK: Equatable

func ==(lhs: Circle, rhs: Circle) -> Bool {
    return CGPointEqualToPoint(lhs.center, rhs.center) && lhs.radius == rhs.radius
}
