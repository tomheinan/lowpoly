//
//  Delaunay.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/3/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

extension Delaunay {
    
    public static func triangulate(vertices: Set<CGPoint>, boundingRect: CGRect) -> Set<Triangle> {
        var values = Set<NSValue>()
        for vertex in vertices {
            values.insert(NSValue(CGPoint: vertex))
        }
        
        let genericTriangles = self.objc_triangulate(values, boundingRect: boundingRect)
        var triangles = Set<Triangle>()
        
        for genericTriangle in genericTriangles {
            if let triangle = genericTriangle as? Triangle {
                triangles.insert(triangle)
            }
        }
        
        return triangles
    }
    
}
