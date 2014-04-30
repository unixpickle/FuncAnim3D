//
//  ANAppDelegate.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AN3DFunctionView.h"
#import "ANSpreadPickerView.h"

@interface ANAppDelegate : NSObject <NSApplicationDelegate> {
  IBOutlet AN3DFunctionView * oglView;
  IBOutlet NSTextField * fnView;
  
  IBOutlet NSTextField * maxTimeView;
  IBOutlet NSButton * animateButton;
  IBOutlet ANSpreadPickerView * spreadPicker;
  
  double timeValue;
  NSTimer * animationTimer;
}

@property (assign) IBOutlet NSWindow * window;

- (IBAction)toggleAnimating:(id)sender;
- (void)spreadChange;

- (void)animationTimer;

@end
