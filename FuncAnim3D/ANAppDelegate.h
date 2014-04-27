//
//  ANAppDelegate.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AN3DFunctionView.h"

@interface ANAppDelegate : NSObject <NSApplicationDelegate> {
  IBOutlet NSOpenGLView * oglView;
  IBOutlet NSTextField * fnView;
}

@property (assign) IBOutlet NSWindow * window;

- (IBAction)functionChanged:(id)sender;

@end
