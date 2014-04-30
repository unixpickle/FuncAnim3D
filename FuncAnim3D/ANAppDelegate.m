//
//  ANAppDelegate.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "ANAppDelegate.h"
#import "FAFunctionModel.h"

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  spreadPicker.target = self;
  spreadPicker.action = @selector(spreadChange);
}

- (IBAction)toggleAnimating:(id)sender {
  if ([animateButton.title isEqualToString:@"Animate"]) {
    animateButton.title = @"Stop";
    animationTimer = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                      target:self
                                                    selector:@selector(animationTimer)
                                                    userInfo:nil
                                                     repeats:YES];
  } else {
    animateButton.title = @"Animate";
    [animationTimer invalidate];
    animationTimer = nil;
  }
}

- (void)animationTimer {
  timeValue += 0.1;
  if (maxTimeView.doubleValue < 0.1) return;
  while (timeValue > maxTimeView.doubleValue) {
    timeValue -= maxTimeView.doubleValue;
  }
  [oglView.model generateWithT:timeValue];
  [oglView setNeedsDisplay:YES];
}

- (void)spreadChange {
  [self functionChanged:nil];
}

- (IBAction)functionChanged:(id)sender {
  FAFunction * fn = [[FAFunction alloc] initWithFuncString:fnView.stringValue];
  [oglView setFunction:fn info:[spreadPicker getSpreader]];
}

@end
