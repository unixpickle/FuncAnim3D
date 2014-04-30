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

@interface FAFunction : NSObject {
  NSString * funcString;
  
  JSContext * context;
  JSVirtualMachine * vm;
}

- (id)initWithFuncString:(NSString *)string;
- (BOOL)evaluate:(double *)output x:(double)x z:(double)z t:(double)t;

- (void)drawInGLContext;

@end
