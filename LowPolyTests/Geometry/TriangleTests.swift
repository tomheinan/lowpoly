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
        let triangle = Triangle(a: CGPoint(x: 0.0, y: 0.0), b: CGPoint(x: 2.0, y: 5.0), c: CGPoint(x: 5.0, y: 0.0))
        let expectedCircumcircle = Circle(center: CGPoint(x: 2.5, y: 1.9), radius: sqrt(9.86))
        
        XCTAssertTrue(triangle.circumcircle == expectedCircumcircle, "Expected \(expectedCircumcircle), got \(triangle.circumcircle)")
    }
    
    func testSharesVertex() {
        let triangle1 = Triangle(a: CGPointMake(0, 0), b: CGPointMake(3, 5), c: CGPointMake(5, 0))
        let triangle2 = Triangle(a: CGPointMake(0, 10), b: CGPointMake(3, 5), c: CGPointMake(5, 10))
        XCTAssertTrue(triangle1.sharesVertex(triangle2), "triangle 1 should share a vertex with triangle 2")
        
        let triangle3 = Triangle(a: CGPointMake(0, 10), b: CGPointMake(3, 6), c: CGPointMake(5, 10))
        XCTAssertFalse(triangle1.sharesVertex(triangle3), "triangle 3 should not share any vertices with triangle 2")
    }
    
}
