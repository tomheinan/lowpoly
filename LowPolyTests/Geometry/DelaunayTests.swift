//
//  DelaunayTests.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/29/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import XCTest

class DelaunayTests: XCTestCase {
    
    func testTriangulation() {
        
    }
    
    func testSupertriangle() {
        let vertices: Set<CGPoint> = [
            CGPoint(x: 201.0, y: 575.0),
            CGPoint(x: 135.0, y: 439.0),
            CGPoint(x: 375.0, y: 0.0),
            CGPoint(x: 98.0, y: 111.0),
            CGPoint(x: 290.0, y: 620.0),
            CGPoint(x: 375.0, y: 667.0),
            CGPoint(x: 0.0, y: 0.0),
            CGPoint(x: 181.0, y: 212.0),
            CGPoint(x: 0.0, y: 667.0)
        ]
        
        let supertriangle = Delaunay.supertriangle(vertices)
        let expectedSupertriangle = Triangle(a: CGPoint(x: -3750, y: -20010), b: CGPoint(x: -3750, y: 7337), c: CGPoint(x: 11625, y: 7337))
        
        XCTAssertEqual(supertriangle, expectedSupertriangle, "Supertriangle dimensions don't match")
    }
    
}
