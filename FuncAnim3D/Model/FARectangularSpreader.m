//
//  AN3DGraphInfo.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/28/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "FARectangularSpreader.h"

@implementation FARectangularSpreader

- (NSInteger)triangleCount {
  return self.xCount * self.yCount * 2;
}

- (void)generateTriangles:(void (^)(GLKVector2 p1, GLKVector2 p2, GLKVector2 p3, CGFloat shade))block {
  // generate each point
  GLfloat stepX = self.sampleWidth / (GLfloat)self.xCount;
  GLfloat stepY = self.sampleHeight / (GLfloat)self.yCount;
  
  BOOL toggle = 0;
  for (int x = 0; x < self.xCount; x++) {
    GLfloat xVal = self.xStart + (GLfloat)x * stepX;
    for (int y = 0; y < self.yCount; y++) {
      GLfloat yVal = self.yStart + (GLfloat)y * stepY;
      
      GLfloat points[2 * 6] = {
        xVal, yVal,
        xVal + stepX, yVal,
        xVal + stepX, yVal + stepY,
        xVal + stepX, yVal + stepY,
        xVal, yVal,
        xVal, yVal + stepY,
      };
      
      block(GLKVector2Make(points[0], points[1]),
            GLKVector2Make(points[2], points[3]),
            GLKVector2Make(points[4], points[5]),
            toggle ? 1.0 : 0.6);
      block(GLKVector2Make(points[6], points[7]),
            GLKVector2Make(points[8], points[9]),
            GLKVector2Make(points[10], points[11]),
            toggle ? 1.0 : 0.6);
      toggle = !toggle;
    }
    if (!(self.yCount % 2)) toggle = !toggle;
  }
}

@end
