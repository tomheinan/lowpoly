//
//  CGRect.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/18/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

extension CGRect {
    
    public enum Orientation {
        case Portrait, Landscape, Square
    }
    
    public var orientation: CGRect.Orientation {
        if fabs(size.width - size.height) < CGFloat.epsilon {
            return Orientation.Square
        } else if size.width > size.height {
            return Orientation.Landscape
        } else {
            return Orientation.Portrait
        }
    }
    
}
