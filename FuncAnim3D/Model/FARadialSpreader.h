//
//  FARadialSpreader.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/29/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAPointSpreader.h"

@interface FARadialSpreader : NSObject <FAPointSpreader>

@property (readwrite) double radius;
@property (readwrite) double centerX, centerY;
@property (readwrite) GLuint rings;
@property (readwrite) GLuint density;

@end
