//
//  Delaunay.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import CoreGraphics

class Delaunay {
    
    static func triangulate(vertices: Set<CGPoint>) -> Set<Triangle> {
        var triangleSet = Set<Triangle>()
        
        // Create supertriangle to encompass all vertices
        
        return triangleSet
    }
    
    static func supertriangle(vertices: Set<CGPoint>) -> Triangle {
        var (minx: CGFloat, miny: CGFloat, maxx: CGFloat, maxy: CGFloat) = (CGFloat.max, CGFloat.max, -CGFloat.max, -CGFloat.max)
        
        // NOTE: There's a bit of a heuristic here. If the bounding triangle
        // is too large and you see overflow/underflow errors. If it is too small
        // you end up with a non-convex hull.
        for vertex in vertices {
            if vertex.x < minx {
                minx = vertex.x
            }
            if vertex.y < miny {
                miny = vertex.y
            }
            if vertex.x > maxx {
                maxx = vertex.x
            }
            if vertex.y > maxy {
                maxy = vertex.y
            }
        }
        
        let dx = (maxx - minx) * 10
        let dy = (maxy - miny) * 10
        
        let a = CGPoint(x: minx - dx, y: miny - dy * 3)
        let b = CGPoint(x: minx - dx, y: maxy + dy)
        let c = CGPoint(x: maxx + dx * 3, y: maxy + dy)
        
        return Triangle(a: a, b: b, c: c)
    }
    
}
