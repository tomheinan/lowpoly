//
//  Mersenne.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/5/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import XCTest

class MersenneTests: XCTestCase {
    
    func testRandsForSeed() {
        let seed = 0
        let count = 5
        
        let rands = Mersenne.objc_randsForSeed(seed, ofCount: count) as! [NSNumber]
        let expectedRands = [
            NSNumber(double: 0.1597933633704609),
            NSNumber(double: 0.9921452096298288),
            NSNumber(double: 0.03956902584486566),
            NSNumber(double: 0.5974946626946718),
            NSNumber(double: 0.5422849699926046)
        ]
        
        #if CGFLOAT_IS_DOUBLE
            let epsilon = CGFloat(DBL_EPSILON)
        #else
            let epsilon = CGFloat(FLT_EPSILON)
        #endif
        
        for var i = 0; i < count; i++ {
            let lhs = CGFloat(rands[i].doubleValue)
            let rhs = CGFloat(expectedRands[i].doubleValue)
            
            XCTAssertTrue(fabs(lhs - rhs) < epsilon, "Generated numbers should be consistent for a given seed")
        }
    }
    
}
