//
//  AN3DModel.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "AN3DModel.h"

@implementation AN3DModel

- (id)initWithVertices:(GLfloat *)verts vertexCount:(GLuint)n {
  if ((self = [super init])) {
    vertexCount = (GLuint)n;
    
    glGenBuffers(1, &buffer);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    glGenVertexArrays(1, &vertexArray);
    glBindVertexArray(vertexArray);
    glBindBuffer(GL_ARRAY_BUFFER, buffer);
    
    _verts = verts;
    glBufferData(GL_ARRAY_BUFFER, n * sizeof(GLfloat) * 10, (void *)verts, GL_DYNAMIC_DRAW);
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 10 * sizeof(GLfloat), 0);
    glEnableVertexAttribArray(GLKVertexAttribColor);
    glVertexAttribPointer(GLKVertexAttribColor, 4, GL_FLOAT,
                          GL_FALSE, 10 * sizeof(GLfloat),
                          (void *)(sizeof(GLfloat) * 3));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT,
                          GL_TRUE, 10 * sizeof(GLfloat),
                          (void *)(sizeof(GLfloat) * 3));
    glBindVertexArray(0);
  }
  return self;
}

- (void)draw {
  glBindVertexArray(vertexArray);
  glBindBuffer(GL_ARRAY_BUFFER, buffer);
  glBufferSubData(GL_ARRAY_BUFFER, 0, sizeof(GLfloat) * 10 * vertexCount, _verts);
  glDrawArrays(GL_TRIANGLES, 0, vertexCount);
}

- (void)dealloc {
  glDeleteBuffers(1, &buffer);
  glDeleteVertexArrays(1, &vertexArray);
}

@end
