//
//  CircleTests.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/1/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import XCTest

class CircleTests: XCTestCase {
    
    func testContains() {
        let circle = Circle(center: CGPoint(x: 3.0, y: 3.0), radius: 3.0)
        let pointInside = CGPoint(x: 5.9, y: 2.9)
        XCTAssertTrue(circle.contains(pointInside), "Point \(pointInside) should be inside circle \(circle)")
        
        let pointOutside = CGPoint(x: 5.9, y: 5.9)
        XCTAssertFalse(circle.contains(pointOutside), "Point \(pointInside) should be outside circle \(circle)")
    }
    
}
