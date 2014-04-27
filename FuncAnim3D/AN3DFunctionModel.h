//
//  AN3DFunctionModel.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "AN3DModel.h"
#import "AN3DFunction.h"

@interface AN3DFunctionModel : AN3DModel {
  AN3DFunction * func;
  GLfloat * data;
  GLuint xCount, yCount;
  
  GLfloat xStart, yStart;
  GLfloat sampleWidth, sampleHeight;
  GLKVector4 color;
}

- (id)initWithFunction:(AN3DFunction *)func
                xCount:(GLuint)xCount
                yCount:(GLuint)yCount
                startX:(GLfloat)xStart
                startY:(GLfloat)yStart
                 width:(GLfloat)sampleWidth
                height:(GLfloat)sampleHeight
                 color:(GLKVector4)color;
- (BOOL)generateWithT:(double)tValue;

@end
