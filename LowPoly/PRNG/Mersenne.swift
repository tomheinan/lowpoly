//
//  Mersenne.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/5/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

public extension Mersenne {
    
    public static func generateVertices(bounds: CGRect, seed: Int, count: Int) -> Set<CGPoint> {
        var vertices = Set<CGPoint>()
        
        let numCoordinates = count * 2
        var numBoundingPoints = Int(round(sqrt(Double(count)) - 2) * 4)
        if numBoundingPoints < 0 {
            numBoundingPoints = 0
        }
        
        let rands = self.objc_rands(seed, count: numCoordinates + numBoundingPoints) as! [NSNumber]
        
        for var i = 0; i < numCoordinates; i += 2 {
            let x = round(CGFloat(rands[i].doubleValue) * CGRectGetWidth(bounds))
            let y = round(CGFloat(rands[i + 1].doubleValue) * CGRectGetHeight(bounds))
            
            vertices.insert(CGPoint(x: x, y: y))
        }
        
        if numBoundingPoints > 0 {
            var numHorizontalBoundingPoints: Int
            var numVerticalBoundingPoints: Int
            
            switch bounds.orientation {
                
            case .Landscape:
                let aspectRatio = CGRectGetHeight(bounds) / CGRectGetWidth(bounds)
                numHorizontalBoundingPoints = Int(round((1.0 - aspectRatio) * CGFloat(numBoundingPoints)))
                numVerticalBoundingPoints = Int(round(aspectRatio * CGFloat(numBoundingPoints)))
                
            case .Portrait:
                let aspectRatio = CGRectGetWidth(bounds) / CGRectGetHeight(bounds)
                numHorizontalBoundingPoints = Int(round(aspectRatio * CGFloat(numBoundingPoints)))
                numVerticalBoundingPoints = Int(round((1.0 - aspectRatio) * CGFloat(numBoundingPoints)))
                
            default:
                numHorizontalBoundingPoints = Int(round(CGFloat(numBoundingPoints) * 0.5))
                numVerticalBoundingPoints = Int(round(CGFloat(numBoundingPoints) * 0.5))
                
            }
            
            var j = 0
            for var i = numCoordinates; i < rands.count - numVerticalBoundingPoints; i++ {
                if j < Int(round(Double(numHorizontalBoundingPoints) * 0.5)) {
                    vertices.insert(CGPoint(x: round(CGFloat(rands[i].doubleValue) * CGRectGetWidth(bounds)), y: CGRectGetMinY(bounds)))
                    j++
                } else {
                    vertices.insert(CGPoint(x: round(CGFloat(rands[i].doubleValue) * CGRectGetWidth(bounds)), y: CGRectGetMaxY(bounds)))
                }
            }
            
            j = 0
            for var i = numCoordinates + numHorizontalBoundingPoints; i < rands.count; i++ {
                if j < Int(round(Double(numVerticalBoundingPoints) * 0.5)) {
                    vertices.insert(CGPoint(x: CGRectGetMinX(bounds), y: round(CGFloat(rands[i].doubleValue) * CGRectGetHeight(bounds))))
                    j++
                } else {
                    vertices.insert(CGPoint(x: CGRectGetMaxX(bounds), y: round(CGFloat(rands[i].doubleValue) * CGRectGetHeight(bounds))))
                }
            }
        }
        
        return vertices
    }
    
}
