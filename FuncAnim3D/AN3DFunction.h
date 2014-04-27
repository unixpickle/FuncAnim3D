//
//  AN3DFunction.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <OpenGL/OpenGL.h>
#import <GLUT/GLUT.h>

@interface AN3DFunction : NSObject {
  NSString * funcString;
  
  JSContext * context;
  JSVirtualMachine * vm;
}

- (id)initWithFuncString:(NSString *)string;
- (BOOL)evaluate:(double *)output x:(double)x y:(double)y t:(double)t;

- (void)drawInGLContext;

@end