//
//  Triangle.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import CoreGraphics

struct Triangle: Equatable, Hashable, Printable {
    
    var a: CGPoint
    var b: CGPoint
    var c: CGPoint
    
    var edges: Set<Edge> {
        return [Edge(start: a, end: b), Edge(start: b, end: c), Edge(start: c, end: a)]
    }
    
    var circumcircle: Circle {
        
        
        let ax = a.x
        let ay = a.y
        let bx = b.x
        let by = b.y
        let cx = c.x
        let cy = c.y
        let fabsy1y2 = fabs(ay - by)
        let fabsy2y3 = fabs(by - cy)
        
        var xc: CGFloat
        var yc: CGFloat
        var m1: CGFloat
        var m2: CGFloat
        var mx1: CGFloat
        var mx2: CGFloat
        var my1: CGFloat
        var my2: CGFloat
        var dx: CGFloat
        var dy: CGFloat
        
        if fabsy1y2 < CGFloat.epsilon {
            m2  = -((cx - bx) / (cy - by))
            mx2 = (bx + cx) / 2.0
            my2 = (by + cy) / 2.0
            xc  = (bx + ax) / 2.0
            yc  = m2 * (xc - mx2) + my2
        }
        
        else if fabsy2y3 < CGFloat.epsilon {
            m1  = -((bx - ax) / (by - ay))
            mx1 = (ax + bx) / 2.0
            my1 = (ay + by) / 2.0
            xc  = (cx + bx) / 2.0
            yc  = m1 * (xc - mx1) + my1
        }
            
        else {
            m1  = -((bx - ax) / (by - ay))
            m2  = -((cx - bx) / (cy - by))
            mx1 = (ax + bx) / 2.0
            mx2 = (bx + cx) / 2.0
            my1 = (ay + by) / 2.0
            my2 = (by + cy) / 2.0
            xc  = (m1 * mx1 - m2 * mx2 + my2 - my1) / (m1 - m2)
            
            if fabsy1y2 > fabsy2y3 {
                yc = m1 * (xc - mx1) + my1
            } else {
                yc = m2 * (xc - mx2) + my2
            }
        }
        
        dx = bx - xc
        dy = by - yc
        
        return Circle(center: CGPointMake(xc, yc), radius: sqrt(dx * dx + dy * dy))
    }
    
    var path: CGPathRef {
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, a.x, a.y)
        CGPathAddLineToPoint(path, nil, b.x, b.y)
        CGPathCloseSubpath(path)
        
        return path
    }

    func sharesVertex(triangle: Triangle) -> Bool {
        let myVertices: Set<CGPoint> = [a, b, c]
        let theirVertices: Set<CGPoint> = [triangle.a, triangle.b, triangle.c]
        
        return !myVertices.isDisjointWith(theirVertices)
    }
    
    // MARK: Hashable
    
    var hashValue: Int {
        let x = a.x + b.x + c.x
        let y = a.y + b.y + c.y
        let sum = Float(x + y)
        return sum.hashValue
    }
    
    // MARK: Printable
    
    var description: String {
        return "<Triangle: a = \(a); b = \(b); c = \(c)>"
    }
    
}

func ==(lhs: Triangle, rhs: Triangle) -> Bool {
    return (CGPointEqualToPoint(lhs.a, rhs.a) && CGPointEqualToPoint(lhs.b, rhs.b) && CGPointEqualToPoint(lhs.c, rhs.c)) || (CGPointEqualToPoint(lhs.a, rhs.b) && CGPointEqualToPoint(lhs.b, rhs.c) && CGPointEqualToPoint(lhs.c, rhs.a)) || (CGPointEqualToPoint(lhs.a, rhs.c) && CGPointEqualToPoint(lhs.b, rhs.a) && CGPointEqualToPoint(lhs.c, rhs.b))
}
