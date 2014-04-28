//
//  AN3DFunctionModel.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "AN3DModel.h"
#import "AN3DFunction.h"
#import "AN3DGraphInfo.h"

@interface AN3DFunctionModel : AN3DModel {
  AN3DFunction * func;
  GLfloat * data;
  AN3DGraphInfo * info;
  GLKVector4 color;
}

- (id)initWithFunction:(AN3DFunction *)func
                  info:(AN3DGraphInfo *)info
                 color:(GLKVector4)color;

- (BOOL)generateWithT:(double)tValue;

@end
