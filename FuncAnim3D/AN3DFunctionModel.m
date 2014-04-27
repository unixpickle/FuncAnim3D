//
//  AN3DFunctionModel.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "AN3DFunctionModel.h"

@implementation AN3DFunctionModel

- (id)initWithFunction:(AN3DFunction *)_func
                xCount:(GLuint)_xCount
                yCount:(GLuint)_yCount
                startX:(GLfloat)_xStart
                startY:(GLfloat)_yStart
                 width:(GLfloat)_sampleWidth
                height:(GLfloat)_sampleHeight
                 color:(GLKVector4)_color {
  GLfloat * _data = (GLfloat *)malloc(sizeof(GLfloat) * 7 * 6 * _xCount * _yCount);
  if (!_data) return nil;
  
  if ((self = [super initWithVertices:_data vertexCount:_xCount * _yCount * 6])) {
    func = _func;
    xCount = _xCount;
    yCount = _yCount;
    
    data = _data;
    xStart = _xStart;
    yStart = _yStart;
    sampleWidth = _sampleWidth;
    sampleHeight = _sampleHeight;
    color = _color;
  } else {
    free(_data);
  }
  return self;
}

- (BOOL)generateWithT:(double)tValue {
  GLfloat colorVector[] = {
    color.x,
    color.y,
    color.z,
    color.w
  };
  
  // generate each point
  GLfloat stepX = sampleWidth / (GLfloat)xCount;
  GLfloat stepY = sampleHeight / (GLfloat)yCount;
  
  size_t offset = 0;
  for (int x = 0; x < xCount; x++) {
    GLfloat xVal = xStart + (GLfloat)x * stepX;
    for (int y = 0; y < yCount; y++) {
      GLfloat yVal = yStart + (GLfloat)y * stepY;
      
      GLfloat points[2 * 6] = {
        xVal, yVal,
        xVal + stepX, yVal,
        xVal + stepX, yVal + stepY,
        xVal + stepX, yVal + stepY,
        xVal, yVal,
        xVal, yVal + stepY,
      };
      
      for (int i = 0; i < 6; i++) {
        memcpy(&data[offset], &points[i * 2], sizeof(GLfloat) * 2);
        offset += sizeof(GLfloat) * 2;
        
        double number;
        BOOL res = [func evaluate:&number x:points[i * 2] y:points[i * 2 + 1] t:tValue];
        if (!res) return NO;
        data[offset] = (GLfloat)number;
        offset += sizeof(GLfloat);
        
        memcpy(&data[offset], colorVector, sizeof(GLfloat) * 4);
        offset += sizeof(GLfloat) * 3;
      }
      
      offset += 7 * 6;
    }
  }
  
  return YES;
}

@end
