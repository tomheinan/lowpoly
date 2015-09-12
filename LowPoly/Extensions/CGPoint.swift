//
//  CGFloat.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import CoreGraphics

extension CGPoint: Hashable {
    
    public var hashValue: Int {
        return Float(x).hashValue ^ Float(y).hashValue
    }
    
}
