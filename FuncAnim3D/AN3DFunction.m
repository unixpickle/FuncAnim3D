//
//  AN3DFunction.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "AN3DFunction.h"

@implementation AN3DFunction

- (id)initWithFuncString:(NSString *)string {
  if ((self = [super init])) {
    funcString = string;
    vm = [[JSVirtualMachine alloc] init];
    context = [[JSContext alloc] initWithVirtualMachine:vm];
    [context setExceptionHandler:^(JSContext * a, JSValue * b) {}];
  }
  return self;
}

- (BOOL)evaluate:(double *)output x:(double)x y:(double)y t:(double)t {
  context[@"x"] = @(x);
  context[@"y"] = @(y);
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
