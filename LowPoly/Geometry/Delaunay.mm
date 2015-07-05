//
//  Delaunay.m
//  LowPoly
//
//  Created by Tom Heinan on 7/3/15.
//  Copyright (c) 2015 Tom Heinan. All rights reserved.
//


#import <LowPoly/LowPoly-Swift.h>

#import "Delaunay.h"
#import "poly2tri.h"

@implementation Delaunay

+ (NSSet *)objc_triangulate:(NSSet *)values boundingRect:(CGRect)boundingRect
{
    NSAssert(values.count >= 3, @"%s requires at least 3 points for a successful triangulation", __PRETTY_FUNCTION__);
    std::vector<p2t::Point *> boundingPoints;
    p2t::CDT *cdt;
    
    boundingPoints.push_back(new p2t::Point(CGRectGetMinX(boundingRect), CGRectGetMinY(boundingRect)));
    boundingPoints.push_back(new p2t::Point(CGRectGetMaxX(boundingRect), CGRectGetMinY(boundingRect)));
    boundingPoints.push_back(new p2t::Point(CGRectGetMaxX(boundingRect), CGRectGetMaxY(boundingRect)));
    boundingPoints.push_back(new p2t::Point(CGRectGetMinX(boundingRect), CGRectGetMaxY(boundingRect)));
    
    cdt = new p2t::CDT(boundingPoints);
    
    for (NSValue *value in values) {
        NSAssert(strcmp(value.objCType, @encode(CGPoint)) == 0, @"Expected a CGPoint, got a %s", value.objCType);
        CGPoint vertex = value.CGPointValue;
        
        if ((vertex.x >= CGRectGetMinX(boundingRect) && vertex.x <= CGRectGetMaxX(boundingRect)) && (vertex.y >= CGRectGetMinY(boundingRect) && vertex.y <= CGRectGetMaxY(boundingRect))) {
            cdt->AddPoint(new p2t::Point((double)vertex.x, (double)vertex.y));
        }
    }
    
    cdt->Triangulate();
    std::vector<p2t::Triangle *> closedTriangles = cdt->GetTriangles();
    
    NSMutableSet *triangles = [[NSMutableSet alloc] initWithCapacity:closedTriangles.size()];
    for (int i = 0; i < closedTriangles.size(); i++) {
        p2t::Triangle& t = *closedTriangles[i];
        p2t::Point& a = *t.GetPoint(0);
        p2t::Point& b = *t.GetPoint(1);
        p2t::Point& c = *t.GetPoint(2);
        
        Triangle *triangle = [[Triangle alloc] initWithA:CGPointMake(a.x, a.y) b:CGPointMake(b.x, b.y) c:CGPointMake(c.x, c.y)];
        [triangles addObject:triangle];
    }
    
    // Cleanup
    delete cdt;
    for (std::vector<p2t::Point *>::iterator it = boundingPoints.begin(); it != boundingPoints.end(); ++it) {
        delete * it;
    }
    boundingPoints.clear();
    
    return triangles;
}

@end
