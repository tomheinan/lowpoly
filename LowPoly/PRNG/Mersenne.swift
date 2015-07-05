//
//  Mersenne.swift
//  LowPoly
//
//  Created by Tom Heinan on 7/5/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

public extension Mersenne {
    
    public static func generateVertices(image: UIImage, count: Int) -> Set<CGPoint> {
        var vertices = Set<CGPoint>()
        
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let dimensions = image.size
        let filesize = imageData.length
        
        let rands = self.objc_rands(filesize, count: count * 2) as! [NSNumber]
        for var i = 0; i < count * 2; i += 2 {
            let x = round(CGFloat(rands[i].doubleValue) * dimensions.width)
            let y = round(CGFloat(rands[i + 1].doubleValue) * dimensions.height)
            
            vertices.insert(CGPoint(x: x, y: y))
        }
        
        return vertices
    }
    
}
