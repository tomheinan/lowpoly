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
        let numBoundingPoints = Int(round(sqrt(Double(count))))
        
        let rands = self.objc_rands(seed, count: numCoordinates) as! [NSNumber]
        
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
                numVerticalBoundingPoints = Int(round((1 - aspectRatio) * CGFloat(numBoundingPoints)))
                numHorizontalBoundingPoints = numBoundingPoints - numVerticalBoundingPoints
                
            case .Portrait:
                let aspectRatio = CGRectGetWidth(bounds) / CGRectGetHeight(bounds)
                numHorizontalBoundingPoints = Int(round((1 - aspectRatio) * CGFloat(numBoundingPoints)))
                numVerticalBoundingPoints = numBoundingPoints - numHorizontalBoundingPoints
                
            default:
                numHorizontalBoundingPoints = Int(round(CGFloat(numBoundingPoints) * 0.5))
                numVerticalBoundingPoints = Int(round(CGFloat(numBoundingPoints) * 0.5))
                
            }
            
            for var i = 1; i < numHorizontalBoundingPoints + 1; i++ {
                let x = (CGFloat(i) / CGFloat(numHorizontalBoundingPoints + 1)) * CGRectGetWidth(bounds)
                vertices.insert(CGPoint(x: x, y: CGRectGetMinY(bounds)))
                vertices.insert(CGPoint(x: x, y: CGRectGetMaxY(bounds)))
            }
            
            for var i = 1; i < numVerticalBoundingPoints + 1; i++ {
                let y = (CGFloat(i) / CGFloat(numVerticalBoundingPoints + 1)) * CGRectGetHeight(bounds)
                vertices.insert(CGPoint(x: CGRectGetMinX(bounds), y: y))
                vertices.insert(CGPoint(x: CGRectGetMaxX(bounds), y: y))
            }
        }
        
        return vertices
    }
    
}
