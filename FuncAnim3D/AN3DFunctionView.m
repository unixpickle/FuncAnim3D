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
    
    rotationMatrix = GLKMatrix4Identity;
    
    float aspect = fabsf([self bounds].size.width / [self bounds].size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(90), aspect, 1, 100.0f);
    effect.transform.projectionMatrix = projectionMatrix;
    
    effect.lightingType = GLKLightingTypePerPixel;
    effect.lightModelAmbientColor = GLKVector4Make(.1f, .1f, .1f, 1);
    effect.colorMaterialEnabled = GL_TRUE;
    
    effect.light1.position = GLKVector4Make(0.0, 5.0, 0.0, 1);
    effect.light1.enabled = GL_TRUE;
    effect.light1.diffuseColor = GLKVector4Make(0.6, 0.6, 0.6, 1);
    effect.light1.ambientColor = GLKVector4Make(0.3, 0.3, 0.3, 1);
    
    self.translation = GLKVector3Make(0, 0, -10);
    self.rotation = GLKVector4Make(0, 0, 0, 1);
    
    [NSOpenGLContext clearCurrentContext];
  }
  return self;
}

- (void)setFrame:(NSRect)frameRect {
  [super setFrame:frameRect];
  [context update];
}

- (void)setFunction:(AN3DFunction *)fn info:(AN3DGraphInfo *)info {
  [context makeCurrentContext];
  AN3DFunctionModel * theModel = [[AN3DFunctionModel alloc] initWithFunction:fn
                                                                        info:info
                                                                       color:GLKVector4Make(1, 0, 0, 1)];
  [theModel generateWithT:0];
  _model = theModel;
  [self setNeedsDisplay:YES];
}

- (void)update {
  float aspect = fabsf([self bounds].size.width / [self bounds].size.height);
  GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(90), aspect, 1, 100.0f);
  effect.transform.projectionMatrix = projectionMatrix;
  [super update];
}

- (void)drawRect:(NSRect)dirtyRect {
  [context setView:self];
  [context makeCurrentContext];
  glClearColor(0, 0, 0, 1.0f);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  
  glViewport(0, 0, [self frame].size.width, [self frame].size.height);
    
  GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(self.translation.x,
                                                         self.translation.y,
                                                         self.translation.z);
  modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix,
                                     self.rotation.x,
                                     self.rotation.y,
                                     self.rotation.z,
                                     self.rotation.w);
  modelViewMatrix = GLKMatrix4Multiply(modelViewMatrix, rotationMatrix);
  effect.transform.modelviewMatrix = modelViewMatrix;
  effect.colorMaterialEnabled = GL_TRUE;
  
  // Render the object with GLKit
  [effect prepareToDraw];
  [self.model draw];
  
  [context flushBuffer];
}

- (void)mouseDown:(NSEvent *)theEvent {
  initialPoint = [theEvent locationInWindow];
  initialRotation = rotationMatrix;
}

- (void)mouseDragged:(NSEvent *)theEvent {
  NSPoint cp = [theEvent locationInWindow];
  CGFloat distance = sqrt(pow(cp.y - initialPoint.y, 2) + pow(cp.x - initialPoint.x, 2));
  if (distance < 2) return;
  
  GLKVector3 normal = GLKVector3Normalize(GLKVector3Make(cp.y - initialPoint.y, initialPoint.x - cp.x, 0));
  rotationMatrix = GLKMatrix4Rotate(initialRotation, -distance / 100, normal.x, normal.y, normal.z);
  [self setNeedsDisplay:YES];
}

- (void)scrollWheel:(NSEvent *)theEvent {
  _translation.z -= theEvent.scrollingDeltaY / 5.0;
  [self setNeedsDisplay:YES];
}

@end
