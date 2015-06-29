//
//  EdgeTests.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import XCTest

class EdgeTests: XCTestCase {
    
    func testLength() {
        let edge = Edge(start: CGPointMake(0, 0), end: CGPointMake(3, 4))
        XCTAssertEqual(edge.length, 5.0, "Length should be 5.0")
    }

    func testSlope() {
        let horizontalEdge = Edge(start: CGPointMake(0, 0), end: CGPointMake(10, 0))
        XCTAssertEqual(horizontalEdge.slope!, 0, "Slope for a horizonal edge should be 0")
        
        let verticalEdge = Edge(start: CGPointMake(0, 0), end: CGPointMake(0, 10))
        XCTAssertNil(verticalEdge.slope, "Slope for a vertical edge should be nil")
        
        let positivelySlopedEdge = Edge(start: CGPointMake(0, 0), end: CGPointMake(5, 10))
        XCTAssertEqual(positivelySlopedEdge.slope!, 2.0, "Slope should be 2.0")
        
        let negativelySlopedEdge = Edge(start: CGPointMake(0, 0), end: CGPointMake(5, -10))
        XCTAssertEqual(negativelySlopedEdge.slope!, -2.0, "Slope should be -2.0")
    }
    
    func testYIntercept() {
        let edge = Edge(start: CGPointMake(-5, 0), end: CGPointMake(5, 10))
        XCTAssertEqual(edge.yIntercept!, CGPointMake(5, 0), "Y intercept should be (5, 0)")
        
        let verticalEdge = Edge(start: CGPointMake(1, 0), end: CGPointMake(1, 10))
        XCTAssertTrue(verticalEdge.yIntercept == nil, "Y intercept should be nil")
    }
    
    func testMidpoint() {
        let edge = Edge(start: CGPointMake(-5, -2), end: CGPointMake(5, 2))
        XCTAssertEqual(edge.midpoint, CGPointMake(0, 0), "Midpoint should be (0, 0)")
    }

}
