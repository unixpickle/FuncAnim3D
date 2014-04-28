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
                  info:(AN3DGraphInfo *)_info
                 color:(GLKVector4)_color {
  GLfloat * _data = (GLfloat *)malloc(sizeof(GLfloat) * 10 * 6 * _info.xCount * _info.yCount);
  if (!_data) return nil;
  
  if ((self = [super initWithVertices:_data vertexCount:_info.xCount * _info.yCount * 6])) {
    func = _func;
    info = _info;
    
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
  GLfloat colorVector[] = {
    color.x,
    color.y,
    color.z,
    color.w
  };
  
  // generate each point
  GLfloat stepX = info.sampleWidth / (GLfloat)info.xCount;
  GLfloat stepY = info.sampleHeight / (GLfloat)info.yCount;
  
  size_t offset = 0;
  for (int x = 0; x < info.xCount; x++) {
    GLfloat xVal = info.xStart + (GLfloat)x * stepX;
    for (int y = 0; y < info.yCount; y++) {
      GLfloat yVal = info.yStart + (GLfloat)y * stepY;
      
      GLfloat points[2 * 6] = {
        xVal, yVal,
        xVal + stepX, yVal,
        xVal + stepX, yVal + stepY,
        xVal + stepX, yVal + stepY,
        xVal, yVal,
        xVal, yVal + stepY,
      };
      
      for (int i = 0; i < 6; i++) {
        data[offset++] = points[i * 2];
        
        double number;
        BOOL res = [func evaluate:&number x:points[i * 2] z:points[i * 2 + 1] t:tValue];
        if (!res) return NO;
        data[offset++] = (GLfloat)number;
        
        data[offset++] = points[i * 2 + 1];
        
        memcpy(&data[offset], colorVector, sizeof(GLfloat) * 4);
        offset += 4;
        
        // skip the normal
        offset += 3;
      }
      
      // generate the normals for both triangles
      for (int i = 0; i < 2; i++) {
        GLfloat * lastData = &data[offset - 60 + (i * 30)];
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
      }
    }
  }
  
  return YES;
}

@end
