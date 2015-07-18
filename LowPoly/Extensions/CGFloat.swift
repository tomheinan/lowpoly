//
//  CGFloat.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/18/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

extension CGFloat {
    
    public static var epsilon: CGFloat {
        return CGFLOAT_IS_DOUBLE == 1 ? CGFloat(DBL_EPSILON) : CGFloat(FLT_EPSILON)
    }
    
}
