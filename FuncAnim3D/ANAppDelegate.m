//
//  ANAppDelegate.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/27/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "ANAppDelegate.h"
#import "AN3DFunctionModel.h"

@implementation ANAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
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

- (IBAction)functionChanged:(id)sender {
  AN3DFunction * fn = [[AN3DFunction alloc] initWithFuncString:fnView.stringValue];
  AN3DGraphInfo * info = [[AN3DGraphInfo alloc] init];
  info.xCount = [samplesXView intValue];
  info.yCount = [samplesYView intValue];
  info.xStart = [startXView doubleValue];
  info.yStart = [startYView doubleValue];
  info.sampleWidth = [sampleWidthView doubleValue];
  info.sampleHeight = [sampleHeightView doubleValue];
  [oglView setFunction:fn info:info];
}

@end
