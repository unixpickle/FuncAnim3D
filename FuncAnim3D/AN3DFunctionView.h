//
//  ANFunctionView.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <GLKit/GLKit.h>
#import "AN3DFunctionModel.h"

@interface AN3DFunctionView : NSOpenGLView {
  NSOpenGLContext * context;
  GLKBaseEffect * effect;
  
  GLKMatrix4 rotationMatrix;
  
  NSPoint initialPoint;
  GLKMatrix4 initialRotation;
}

@property (readwrite) GLKVector4 rotation;
@property (readwrite) GLKVector3 translation;
@property (readwrite) AN3DFunctionModel * model;

- (void)setFunction:(AN3DFunction *)fn info:(AN3DGraphInfo *)info;

@end
