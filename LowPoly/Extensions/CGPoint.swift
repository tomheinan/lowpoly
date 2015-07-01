//
//  CGFloat.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import CoreGraphics

extension CGPoint: Equatable, Hashable {
    
    public var hashValue: Int {
        return Float(x).hashValue ^ Float(y).hashValue
    }
    
}

public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool {
    return CGPointEqualToPoint(lhs, rhs)
}
