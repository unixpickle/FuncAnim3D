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
  IBOutlet AN3DFunctionView * oglView;
  IBOutlet NSTextField * fnView;
  
  IBOutlet NSTextField * samplesXView, * samplesYView;
  IBOutlet NSTextField * startXView, * startYView;
  IBOutlet NSTextField * sampleWidthView, * sampleHeightView;
  
  IBOutlet NSTextField * maxTimeView;
  IBOutlet NSButton * animateButton;
  
  double timeValue;
  NSTimer * animationTimer;
}

@property (assign) IBOutlet NSWindow * window;

- (IBAction)toggleAnimating:(id)sender;

- (void)animationTimer;

@end
