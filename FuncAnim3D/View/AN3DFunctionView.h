//
//  ANFunctionView.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <GLKit/GLKit.h>
#import "FAFunctionModel.h"
#import "FARectangularSpreader.h"

@interface AN3DFunctionView : NSOpenGLView {
  NSOpenGLContext * context;
  GLKBaseEffect * effect;
  
  GLKMatrix4 rotationMatrix;
  
  NSPoint initialPoint;
  GLKMatrix4 initialRotation;
}

@property (readwrite) GLKVector4 rotation;
@property (readwrite) GLKVector3 translation;
@property (readwrite) FAFunctionModel * model;

- (void)setFunction:(FAFunction *)fn info:(FARectangularSpreader *)info;

@end
