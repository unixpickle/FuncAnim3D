//
//  ANSpreadPickerView.h
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/29/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FARectangularSpreader.h"
#import "FARadialSpreader.h"

@interface ANSpreadPickerView : NSView {
  IBOutlet NSView * radialView;
  IBOutlet NSView * rectangularView;
  IBOutlet NSView * mainView;
  
  IBOutlet NSTextField * rectSamplesX, * rectSamplesY;
  IBOutlet NSTextField * rectStartX, * rectStartY;
  IBOutlet NSTextField * rectWidth, * rectHeight;
  
  IBOutlet NSTextField * radRings, * radDensity;
  IBOutlet NSTextField * radRadius;
  IBOutlet NSTextField * radCenterX, * radCenterZ;
  
  IBOutlet NSPopUpButton * popUp;
}

@property (nonatomic, weak) id target;
@property (readwrite) SEL action;

- (id)initWithFrame:(NSRect)frameRect;
- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)showAppropriateView;
- (IBAction)popUpChange:(id)sender;
- (IBAction)valueChange:(id)sender;

- (id<FAPointSpreader>)getSpreader;

@end
