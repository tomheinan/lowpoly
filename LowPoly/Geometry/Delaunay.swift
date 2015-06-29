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
        
        // TODO: For some reason, Xcode won't compile this if it's defined on a CGFloat extension,
        // so that's why it's here instead
        #if CGFLOAT_IS_DOUBLE
            let CGFLOAT_EPSILON = CGFloat(DBL_EPSILON)
        #else
            let CGFLOAT_EPSILON = CGFloat(FLT_EPSILON)
        #endif
        
        // We need at least three vertices to generate a triangulation
        if vertices.count < 3 {
            return triangleSet
        }
        
        let supertriangle = self.supertriangle(vertices)
        
        // Generate an array of vertices sorted by x value, least to greatest
        var sortedVertices = Array(vertices)
        sortedVertices.sort({ $0.x < $1.x })
        
        var openTriangles = [supertriangle]
        var closedTriangles = [Triangle]()
        
        // Add each vertex to the mesh
        for vertex in sortedVertices {
            
            var edges = Set<Edge>()
            
            /* For each open triangle, check to see if the current point is
             * inside it's circumcircle. If it is, remove the triangle and add
             * its edges to an edge list. */
            for var i = openTriangles.count - 1; i >= 0; --i {
                let triangle = openTriangles[i]
                let circumcircle = triangle.circumcircle
                
                /* If this point is to the right of this triangle's circumcircle,
                * then this triangle should never get checked again. Remove it
                * from the open list, add it to the closed list, and skip. */
                let dx = vertex.x - circumcircle.center.x
                if dx > 0 && dx > circumcircle.radius {
                    closedTriangles.append(triangle)
                    openTriangles.removeAtIndex(i)
                    continue
                }
                
                /* If we're outside the circumcircle, skip this triangle. */
                let dy = vertex.y - circumcircle.center.y
                if sqrt(dx * dx + dy * dy) - circumcircle.radius > CGFLOAT_EPSILON {
                    continue
                }
                
                /* Remove the triangle and add its edges to the edge list. */
                edges.unionInPlace(triangle.edges)
                openTriangles.removeAtIndex(i)
            }
            
            /* Add a new triangle for each edge. */
            for edge in edges {
                openTriangles.append(Triangle(a: edge.start, b: edge.end, c: vertex))
            }
        }
        
        /* Copy any remaining open triangles to the closed list, and then
         * remove any triangles that share a vertex with the supertriangle,
         * building a list of triplets that represent triangles. */
        for triangle in openTriangles {
            closedTriangles.append(triangle)
        }
        
        for triangle in closedTriangles {
            if !triangle.sharesVertex(supertriangle) {
                triangleSet.insert(triangle)
            }
        }
        
        return triangleSet
    }
    
    static func supertriangle(vertices: Set<CGPoint>) -> Triangle {
        var (xmin: CGFloat, xmax: CGFloat, ymin: CGFloat, ymax: CGFloat) = (0, 0, 0, 0)
        
        for vertex in vertices {
            if vertex.x < xmin { xmin = vertex.x }
            if vertex.x > xmax { xmax = vertex.x }
            if vertex.y < ymin { ymin = vertex.y }
            if vertex.y > ymax { ymax = vertex.y }
        }
        
        // TODO: Improve this to largest incircle for equilateral triangle
        
        let dx = xmax - xmin
        let dy = ymax - ymin
        let dmax = max(dx, dy)
        let xmid = xmin + (dx * 0.5)
        let ymid = ymin + (dy * 0.5)
        
        return Triangle(a: CGPointMake(xmid - (20 * dmax), ymid - dmax), b: CGPointMake(xmid, ymid + (20 * dmax)), c: CGPointMake(xmid + (20 * dmax), ymid - dmax))
    }
    
}
