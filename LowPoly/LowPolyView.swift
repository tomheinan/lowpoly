//
//  LowPolyView.swift
//  LowPoly
//
//  Created by Tom Heinan on 6/27/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//

import UIKit
import CoreGraphics

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
    
    private var _vertexDensity:Int = 25
    
    // MARK: Initialization
    
    func commonInit() {
        //backgroundColor = UIColor.redColor()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    // MARK: Custom drawing
    
    public override func drawRect(rect: CGRect) {
        if let image = self.image {
            let context = UIGraphicsGetCurrentContext()
            
            // First, we need to scale our sample image so that it fits within the bounds
            // of the view rect (aspect fill)
            var imageFrame = CGRect(origin: CGPoint(x: 0, y: 0), size: image.size)
            
            switch (rect.orientation, imageFrame.orientation) {
                
            case (.Landscape, .Landscape), (.Portrait, .Landscape), (.Square, .Landscape), (.Portrait, .Square):
                // Scale imageBounds height to match rect
                let scaleFactor = CGRectGetHeight(rect) / CGRectGetHeight(imageFrame)
                imageFrame = CGRectApplyAffineTransform(imageFrame, CGAffineTransformMakeScale(scaleFactor, scaleFactor))
                
                if rect.orientation == imageFrame.orientation && CGRectGetWidth(rect) > CGRectGetWidth(imageFrame) {
                    let aspectFillFactor = CGRectGetWidth(rect) / CGRectGetWidth(imageFrame)
                    imageFrame = CGRectApplyAffineTransform(imageFrame, CGAffineTransformMakeScale(aspectFillFactor, aspectFillFactor))
                }
                
            case (.Landscape, .Portrait), (.Portrait, .Portrait), (.Square, .Portrait), (.Landscape, .Square):
                // scale imageBounds width to match rect
                let scaleFactor = CGRectGetWidth(rect) / CGRectGetWidth(imageFrame)
                imageFrame = CGRectApplyAffineTransform(imageFrame, CGAffineTransformMakeScale(scaleFactor, scaleFactor))
                
                if rect.orientation == imageFrame.orientation && CGRectGetHeight(rect) > CGRectGetHeight(imageFrame) {
                    let aspectFillFactor = CGRectGetHeight(rect) / CGRectGetHeight(imageFrame)
                    imageFrame = CGRectApplyAffineTransform(imageFrame, CGAffineTransformMakeScale(aspectFillFactor, aspectFillFactor))
                }
                
            default:
                let scaleFactor = CGRectGetWidth(rect) / CGRectGetWidth(imageFrame)
                imageFrame = CGRectApplyAffineTransform(imageFrame, CGAffineTransformMakeScale(scaleFactor, scaleFactor))
                
            }
            
            if CGRectGetWidth(imageFrame) > CGRectGetWidth(rect) {
                let xOffset = (CGRectGetWidth(rect) - CGRectGetWidth(imageFrame)) * 0.5
                imageFrame.origin = CGPoint(x: imageFrame.origin.x + xOffset, y: imageFrame.origin.y)
            }
            if CGRectGetHeight(imageFrame) > CGRectGetHeight(rect) {
                let yOffset = (CGRectGetHeight(rect) - CGRectGetHeight(imageFrame)) * 0.5
                imageFrame.origin = CGPoint(x: imageFrame.origin.x, y: imageFrame.origin.y - yOffset)
            }
            
            let imageHeight = CGImageGetHeight(image.CGImage)
            let bytesPerRow = CGImageGetBytesPerRow(image.CGImage)
            let imageSizeInBytes = imageHeight * bytesPerRow
            
            let vertices = Mersenne.generateVertices(rect, seed: imageSizeInBytes, count: vertexDensity)
            
            // Then we can triangulate
            let triangles = Delaunay.triangulate(vertices, boundingRect: rect)
            for triangle in triangles {
                let color = colorAtPoint(triangle.centroid, imageFrame: imageFrame)
                
                // Faux antialiasing
                CGContextAddPath(context, triangle.path)
                CGContextSetLineWidth(context, 0.5)
                CGContextSetStrokeColorWithColor(context, color.CGColor)
                CGContextStrokePath(context)
                
                // Fill in those triangles!
                CGContextAddPath(context, triangle.path)
                CGContextSetFillColorWithColor(context, color.CGColor)
                CGContextFillPath(context)
            }
            
            CGContextClipToRect(context, rect)
        }
    }
    
    // MARK: Private methods
    
    func colorAtPoint(point: CGPoint, imageFrame: CGRect) -> UIColor {
        if let image = self.image {
            let pixel = UnsafeMutablePointer<CUnsignedChar>.alloc(4)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.PremultipliedLast.rawValue)
            let context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, bitmapInfo.rawValue)
            
            CGContextTranslateCTM(context, -point.x, -(CGRectGetHeight(imageFrame) - point.y))
            CGContextDrawImage(context, imageFrame, image.CGImage)
            
            let color = UIColor(red: CGFloat(pixel[0]) / 255.0, green: CGFloat(pixel[1]) / 255.0, blue: CGFloat(pixel[2]) / 255.0, alpha: CGFloat(pixel[3]) / 255.0)
            pixel.dealloc(4)
            
            return color
        } else {
            return UIColor.clearColor()
        }
    }

}
