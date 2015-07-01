//
//  CGFloat.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/1/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

extension CGFloat {
    
    public static var epsilon: CGFloat {
        #if CGFLOAT_IS_DOUBLE
            return CGFloat(DBL_EPSILON)
        #else
            return CGFloat(FLT_EPSILON)
        #endif
    }
    
}
