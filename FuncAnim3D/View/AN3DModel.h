//
//  AN3DModel.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GLKit/GLKit.h>
#import <OpenGL/gl3.h>

@interface AN3DModel : NSObject {
  GLuint buffer;
  GLuint vertexArray;
  GLuint vertexCount;
  void * _verts;
}

- (id)initWithVertices:(GLfloat *)verts vertexCount:(GLuint)count;
- (void)draw;

@end
