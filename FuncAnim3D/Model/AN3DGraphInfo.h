//
//  AN3DGraphInfo.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/28/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>

@interface AN3DGraphInfo : NSObject

@property (readwrite) GLuint xCount, yCount;
@property (readwrite) GLfloat xStart, yStart;
@property (readwrite) GLfloat sampleWidth, sampleHeight;

@end
