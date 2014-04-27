//
//  ANFunctionView.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "AN3DFunctionView.h"

@implementation AN3DFunctionView

- (id)initWithCoder:(NSCoder *)coder {
  NSOpenGLPixelFormatAttribute attrs[] = {
    NSOpenGLPFADoubleBuffer,
    NSOpenGLPFADepthSize, 32,
    NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion3_2Core,
    0
  };
  
  NSOpenGLPixelFormat * format = [[NSOpenGLPixelFormat alloc] initWithAttributes:attrs];
  
  self = [super initWithCoder:coder];
  if (self) {
    context = [[NSOpenGLContext alloc] initWithFormat:format shareContext:nil];
    [context makeCurrentContext];
    
    glEnable(GL_DEPTH_TEST);
    
    effect = [[GLKBaseEffect alloc] init];
    
    float aspect = fabsf([self bounds].size.width / [self bounds].size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(25), aspect, 1, 100.0f);
    effect.transform.projectionMatrix = projectionMatrix;
    
    self.translation = GLKVector3Make(0, 0, -10);
    self.rotation = GLKVector4Make(0, 0, 0, 1);
    
    [NSOpenGLContext clearCurrentContext];
  }
  return self;
}

- (void)update {
  [super update];
}

- (void)drawRect:(NSRect)dirtyRect {
  [context clearDrawable];
  [context setView:self];
  [context makeCurrentContext];
  // Drawing code here.
  glClearColor(0, 0, 0, 1.0f);
  NSLog(@"%d", glGetError());
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  NSLog(@"%d", glGetError());
  
  glViewport(0, 0, [self frame].size.width, [self frame].size.height);
  NSLog(@"%d", glGetError());
    
  GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(self.translation.x,
                                                         self.translation.y,
                                                         self.translation.z);
  modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix,
                                     self.rotation.x,
                                     self.rotation.y,
                                     self.rotation.z,
                                     self.rotation.w);
  effect.transform.modelviewMatrix = modelViewMatrix;
  effect.colorMaterialEnabled = GL_TRUE;
  
  // Render the object with GLKit
  [effect prepareToDraw];
  
  GLfloat vertices[21] = {
    0, 0, 0, 1, 0, 0, 1,
    10, 10, 0, 1, 0, 0, 1,
    0, 10, 0, 1, 0, 0, 1
  };
  model = [[AN3DModel alloc] initWithVertices:vertices vertexCount:3];
  [model draw];
  model = nil;
  
  NSLog(@"error after all %d", glGetError());
  
  [context flushBuffer];
  [NSOpenGLContext clearCurrentContext];
}

@end
