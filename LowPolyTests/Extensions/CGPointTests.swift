//
//  CGPointTests.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/1/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import XCTest
@testable import LowPoly

class CGPointTests: XCTestCase {
    
    func testHashable() {
        let p0 = CGPoint(x: 42, y: 100)
        let p1 = CGPoint(x: 42, y: 100)
        XCTAssertEqual(p0.hashValue, p1.hashValue, "Hash values should match")
        
        let p2 = CGPoint(x: 43, y: 100)
        XCTAssertNotEqual(p0.hashValue, p2.hashValue, "Hash values should not match")
    }
    
    func testEquatable() {
        let p0 = CGPoint(x: 42, y: 100)
        let p1 = CGPoint(x: 42, y: 100)
        XCTAssertTrue(p0 == p1, "Points should be equal")
        
        let p2 = CGPoint(x: 43, y: 100)
        XCTAssertFalse(p0 == p2, "Points should not be equal")
    }
    
}
