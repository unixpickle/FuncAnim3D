//
//  AN3DFunction.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "FAFunction.h"

@implementation FAFunction

- (id)initWithFuncString:(NSString *)string {
  if ((self = [super init])) {
    funcString = string;
    vm = [[JSVirtualMachine alloc] init];
    context = [[JSContext alloc] initWithVirtualMachine:vm];
    [context setExceptionHandler:^(JSContext * a, JSValue * b) {}];
  }
  return self;
}

- (BOOL)evaluate:(double *)output x:(double)x z:(double)z t:(double)t {
  context[@"x"] = @(x);
  context[@"z"] = @(z);
  context[@"t"] = @(t);
  JSValue * value = [context evaluateScript:funcString];
  if ([context exception]) return NO;
  if (![value isNumber]) return NO;
  
  *output = value.toNumber.doubleValue;
  return YES;
}

- (void)drawInGLContext {
}

@end
