//
//  ANFunctionView.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <GLKit/GLKit.h>
#import "AN3DModel.h"

@interface AN3DFunctionView : NSOpenGLView {
  NSOpenGLContext * context;
  GLKBaseEffect * effect;
}

@property (readwrite) GLKVector4 rotation;
@property (readwrite) GLKVector3 translation;

@end
