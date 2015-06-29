//
//  TriangleTests.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/28/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import XCTest

class TriangleTests: XCTestCase {
    
    func testCircumcircle() {
        let edge = Edge(start: CGPointMake(0, 10), end: CGPointMake(10, 0))
        let triangle = Triangle(a: CGPointMake(0, 0), b: edge.start, c: edge.end)
        
        let expectedCircumcircle = Circle(center: CGPointMake(5.0, 5.0), radius: edge.length / 2)
        XCTAssertTrue(triangle.circumcircle == expectedCircumcircle, "Should be a circle with center \(expectedCircumcircle.center) and radius \(expectedCircumcircle.radius)")
    }
    
    func testSharesVertex() {
        let triangle1 = Triangle(a: CGPointMake(0, 0), b: CGPointMake(3, 5), c: CGPointMake(5, 0))
        let triangle2 = Triangle(a: CGPointMake(0, 10), b: CGPointMake(3, 5), c: CGPointMake(5, 10))
        XCTAssertTrue(triangle1.sharesVertex(triangle2), "triangle 1 should share a vertex with triangle 2")
        
        let triangle3 = Triangle(a: CGPointMake(0, 10), b: CGPointMake(3, 6), c: CGPointMake(5, 10))
        XCTAssertFalse(triangle1.sharesVertex(triangle3), "triangle 3 should not share any vertices with triangle 2")
    }
    
}
