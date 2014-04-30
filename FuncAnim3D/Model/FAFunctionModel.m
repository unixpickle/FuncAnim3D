//
//  AN3DFunctionModel.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "FAFunctionModel.h"

@implementation FAFunctionModel

- (id)initWithFunction:(FAFunction *)_func
              spreader:(id<FAPointSpreader>)_spreader
                 color:(GLKVector4)_color {
  GLfloat * _data = (GLfloat *)malloc(sizeof(GLfloat) * 30 * [_spreader triangleCount]);
  if (!_data) return nil;
  
  GLuint vCount = (GLuint)([_spreader triangleCount] * 3);
  if ((self = [super initWithVertices:_data vertexCount:vCount])) {
    func = _func;
    spreader = _spreader;
    
    data = _data;
    color = _color;
  } else {
    free(_data);
  }
  return self;
}

- (void)dealloc {
  free(data);
}

- (BOOL)generateWithT:(double)tValue {
  GLfloat colorVector1[] = {
    color.x,
    color.y,
    color.z,
    color.w
  };
  
  __block GLfloat * colorVectorPtr = colorVector1;
  
  __block size_t offset = 0;
  [spreader generateTriangles:^(GLKVector2 p1, GLKVector2 p2, GLKVector2 p3, CGFloat shade) {
    GLfloat points[6] = {
      p1.x, p1.y,
      p2.x, p2.y,
      p3.x, p3.y,
    };
    
    for (int i = 0; i < 3; i++) {
      data[offset++] = points[i * 2];
      
      double number;
      BOOL res = [func evaluate:&number x:points[i * 2] z:points[i * 2 + 1] t:tValue];
      if (!res) return;
      data[offset++] = (GLfloat)number;
      
      data[offset++] = points[i * 2 + 1];
      
      GLfloat theColor[4] = {
        colorVectorPtr[0] * shade,
        colorVectorPtr[1] * shade,
        colorVectorPtr[2] * shade,
        colorVectorPtr[3] * shade
      };
      memcpy(&data[offset], theColor, sizeof(GLfloat) * 4);
      offset += 4;
      
      // skip the normal
      offset += 3;
    }
    
    GLfloat * lastData = &data[offset - 30];
    GLKVector3 v1 = GLKVector3Make(lastData[0] - lastData[10],
                                   lastData[1] - lastData[11],
                                   lastData[2] - lastData[12]);
    GLKVector3 v2 = GLKVector3Make(lastData[20] - lastData[10],
                                   lastData[21] - lastData[11],
                                   lastData[22] - lastData[12]);
    GLKVector3 cross = GLKVector3Normalize(GLKVector3CrossProduct(v1, v2));
    lastData[7] = cross.x;
    lastData[8] = cross.y;
    lastData[9] = cross.z;
    memcpy(&lastData[17], &lastData[7], sizeof(GLfloat) * 3);
    memcpy(&lastData[27], &lastData[7], sizeof(GLfloat) * 3);
  }];
    
  return YES;
}

@end
