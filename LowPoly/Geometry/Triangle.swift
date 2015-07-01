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
        let A = b.x - a.x
        let B = b.y - a.y
        let C = c.x - a.x
        let D = c.y - a.y
        
        let E = A * (a.x + b.x) + B * (a.y + b.y)
        let F = C * (a.x + c.x) + D * (a.y + c.y)
        
        let G = 2.0 * (A * (c.y - b.y) - B * (c.x - b.x))
        
        var center: CGPoint
        var dx: CGFloat
        var dy: CGFloat
        
        if (fabs(G) < CGFloat.epsilon) {
            // Collinear - find extremes and use the midpoint
            let minx = min(a.x, b.x, c.x)
            let miny = min(a.y, b.y, c.y)
            let maxx = max(a.x, b.x, c.x)
            let maxy = max(a.y, b.y, c.y)
            
            center = CGPoint(x: (minx + maxx) * 0.5, y: (miny + maxy) * 0.5)
            dx = center.x - minx
            dy = center.y - miny
        }
        else {
            let cx = (D * E - B * F) / G
            let cy = (A * F - C * E) / G
            
            center = CGPoint(x: cx, y: cy)
            dx = center.x - a.x
            dy = center.y - a.y
        }
        
        let radius = sqrt(dx * dx + dy * dy)
        
        return Circle(center: center, radius: radius)
    }
    
    var path: CGPath {
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
