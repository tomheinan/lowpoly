//
//  LowPolyView.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit

@IBDesignable
public class LowPolyView: UIView {
    
    // MARK: Properties
    
    @IBInspectable public var image: UIImage? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable public var vertexDensity: Int {
        get {
            return _vertexDensity
        }
        set(newVertexDensity) {
            if newVertexDensity < 3 {
                _vertexDensity = 3
            } else {
                _vertexDensity = newVertexDensity
            }
            
            self.setNeedsDisplay()
        }
    }
    
    private var _vertexDensity:Int = 10
    
    // MARK: Initialization
    
    func commonInit() {
        //backgroundColor = UIColor.redColor()
    }
    
    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    // MARK: Custom drawing
    
    public override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, UIColor(red: 0, green: 0, blue: 127/255.0, alpha: 1.0).CGColor)
        CGContextFillRect(context, rect)
        
        var vertices = Set<CGPoint>()
        
        // Random Vertices
        let numVertices = vertexDensity
        let insetRect = CGRectInset(rect, 20, 20)
        for var i = 0; i < numVertices; i++ {
            let x = CGFloat(arc4random_uniform(UInt32(round(CGRectGetWidth(insetRect) - rect.origin.x)))) + insetRect.origin.x
            let y = CGFloat(arc4random_uniform(UInt32(round(CGRectGetHeight(insetRect) - rect.origin.y)))) + insetRect.origin.y
            
            vertices.insert(CGPointMake(x, y))
        }
        
        // Draw Vertices
        CGContextSetFillColorWithColor(context, UIColor(white: 1.0, alpha: 1.0).CGColor)
        for vertex in vertices {
            let dotSize: CGFloat = 5.0
            
            CGContextFillEllipseInRect(context, CGRectMake(vertex.x - (dotSize * 0.5), vertex.y - (dotSize * 0.5), dotSize, dotSize))
        }
        
        // Triangulation
        let triangles = Delaunay.triangulate(vertices, boundingRect: rect)
        for triangle in triangles {
            CGContextAddPath(context, triangle.path)
            CGContextSetStrokeColorWithColor(context, UIColor(white: 1.0, alpha: 1.0).CGColor)
            CGContextStrokePath(context)
        }
        
    }

}
