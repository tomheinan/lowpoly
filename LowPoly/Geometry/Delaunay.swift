//
//  Delaunay.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import CoreGraphics

class Delaunay {
    
    static func triangulate(vertices: Array<CGPoint>) -> Set<Triangle> {
        var triangles = Set<Triangle>()
        
        // Create supertriangle to encompass all vertices
        let supertriangle = self.supertriangle(vertices)
        triangles.insert(supertriangle)
        
        // Loop through the vertices and triangulate them
        for vertex in vertices {
            println("-- vertex \(vertex) --")
            println("   started with \(triangles.count) triangles")
            
            // NOTE: This is O(n^2) - can be optimized by sorting vertices
            // along the x-axis and only considering triangles that have
            // potentially overlapping circumcircles
            var edges = Set<Edge>()
            
            // Remove triangles with circumcircles containing the vertex
            var trianglesRemoved = 0
            for triangle in triangles {
                if triangle.circumcircle.contains(vertex) {
                    edges.unionInPlace(triangle.edges)
                    triangles.remove(triangle)
                    trianglesRemoved++
                }
            }
            println("   removed \(trianglesRemoved) triangles")
            
            // Create new triangles from the unique edges and new vertex
            var trianglesAdded = 0
            for edge in edges {
                triangles.insert(Triangle(a: edge.start, b: edge.end, c: vertex))
                trianglesAdded++
            }
            println("   added \(trianglesAdded) triangles from \(edges.count) edges")
            println("   ended with \(triangles.count) triangles")
        }
        
        // Remove triangles that share a vertex with the supertriangle
        println("-- cleanup --")
        var trianglesRemoved = 0
        for triangle in triangles {
            if triangle.sharesVertex(supertriangle) {
                triangles.remove(triangle)
                trianglesRemoved++
            }
        }
        println("   removed \(trianglesRemoved) triangles that share vertices with the supertriangle")
        println("   ended with  \(triangles.count) triangles total")
        
        return Set(triangles)
    }
    
    static func supertriangle(vertices: Array<CGPoint>) -> Triangle {
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
