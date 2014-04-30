//
//  AN3DGraphInfo.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/28/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "FAPointSpreader.h"

@interface FARectangularSpreader : NSObject <FAPointSpreader>

@property (readwrite) GLuint xCount, yCount;
@property (readwrite) GLfloat xStart, yStart;
@property (readwrite) GLfloat sampleWidth, sampleHeight;

@end
