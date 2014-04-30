//
//  FARadialSpreader.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/29/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "FARadialSpreader.h"

@implementation FARadialSpreader

- (NSInteger)triangleCount {
  NSInteger triCount = 0;
  
  // going from the center to the inner ring we make triangles
  triCount += self.density;
  
  // going from the outer rings to more outer rings we make squares
  triCount += self.density * (self.rings - 1) * 2;
  
  return triCount;
}

- (void)generateTriangles:(void (^)(GLKVector2 p1, GLKVector2 p2, GLKVector2 p3, CGFloat shade))block {
  CGFloat angleStep = M_PI * 2.0 / (CGFloat)self.density;
  CGFloat radialStep = self.radius / (CGFloat)self.rings;
  GLKVector2 center = GLKVector2Make(self.centerX, self.centerY);
  
  BOOL toggle = 0;
  
  // generate inner points
  for (int i = 0; i < self.density; i++) {
    CGFloat startAngle = (CGFloat)i * angleStep;
    CGFloat stopAngle = startAngle + angleStep;
    GLKVector2 point1 = GLKVector2Make(self.centerX + cos(startAngle) * radialStep,
                                       self.centerY + sin(startAngle) * radialStep);
    GLKVector2 point2 = GLKVector2Make(self.centerX + cos(stopAngle) * radialStep,
                                       self.centerY + sin(stopAngle) * radialStep);
    block(point1, center, point2, toggle ? 1.0 : 0.9);
    toggle = !toggle;
  }
  
  // generate outer points
  for (int i = 1; i < self.rings; i++) {
    for (int j = 0; j < self.density; j++) {
      CGFloat startAngle = (CGFloat)j * angleStep;
      CGFloat stopAngle = (CGFloat)(j + 1) * angleStep;
      
      CGFloat innerRadius = radialStep * (CGFloat)i;
      CGFloat outerRadius = innerRadius + radialStep;
      
      // generate the four points
      GLKVector2 innerPoint1 = GLKVector2Make(self.centerX + cos(startAngle) * innerRadius,
                                              self.centerY + sin(startAngle) * innerRadius);
      GLKVector2 innerPoint2 = GLKVector2Make(self.centerX + cos(stopAngle) * innerRadius,
                                              self.centerY + sin(stopAngle) * innerRadius);
      GLKVector2 outerPoint1 = GLKVector2Make(self.centerX + cos(startAngle) * outerRadius,
                                              self.centerY + sin(startAngle) * outerRadius);
      GLKVector2 outerPoint2 = GLKVector2Make(self.centerX + cos(stopAngle) * outerRadius,
                                              self.centerY + sin(stopAngle) * outerRadius);
      block(innerPoint1, outerPoint1, innerPoint2, toggle ? 1.0 : 0.9);
      block(innerPoint2, outerPoint2, outerPoint1, toggle ? 1.0 : 0.9);
      toggle = !toggle;
    }
  }
}

@end
