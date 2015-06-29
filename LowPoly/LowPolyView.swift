//
//  LowPolyView.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

@IBDesignable
class LowPolyView: UIView {
    
    @IBInspectable var image: UIImage?
    
    // MARK: Initialization
    
    func commonInit() {
        //backgroundColor = UIColor.redColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    // MARK: Custom drawing
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, UIColor(red: 0, green: 0, blue: 127/255.0, alpha: 1.0).CGColor)
        CGContextFillRect(context, rect)
        
        var vertices = Set<CGPoint>()
        
        // Corners
        vertices.insert(rect.origin)
        vertices.insert(CGPointMake(rect.origin.x, rect.origin.y + rect.size.height))
        vertices.insert(CGPointMake(rect.origin.x + rect.size.width, rect.origin.y))
        vertices.insert(CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height))
        
        // Random Vertices
        let numVertices = 100
        for var i = 0; i < numVertices; i++ {
            let x = CGFloat(arc4random_uniform(UInt32(round(CGRectGetWidth(rect) - rect.origin.x)))) + rect.origin.x
            let y = CGFloat(arc4random_uniform(UInt32(round(CGRectGetHeight(rect) - rect.origin.y)))) + rect.origin.y
            
            vertices.insert(CGPointMake(x, y))
        }
        
        CGContextSetFillColorWithColor(context, UIColor(white: 1.0, alpha: 1.0).CGColor)
        for vertex in vertices {
            let dotSize: CGFloat = 5.0
            
            CGContextFillEllipseInRect(context, CGRectMake(vertex.x - (dotSize * 0.5), vertex.y - (dotSize * 0.5), dotSize, dotSize))
        }
    }

}
