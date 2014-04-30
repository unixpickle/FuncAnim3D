//
//  AN3DFunctionModel.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "AN3DModel.h"
#import "FAFunction.h"
#import "FAPointSpreader.h"

@interface FAFunctionModel : AN3DModel {
  FAFunction * func;
  GLfloat * data;
  id<FAPointSpreader> spreader;
  GLKVector4 color;
}

- (id)initWithFunction:(FAFunction *)func
              spreader:(id<FAPointSpreader>)spreader
                 color:(GLKVector4)color;

- (BOOL)generateWithT:(double)tValue;

@end
