//
//  FAPointSpreader.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/29/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>


@protocol FAPointSpreader <NSObject>

- (NSInteger)triangleCount;
- (void)generateTriangles:(void (^)(GLKVector2 p1, GLKVector2 p2, GLKVector2 p3, CGFloat shade))block;

@end
