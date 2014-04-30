//
//  ANSpreadPickerView.m
//  FuncAnim3D
//
//  Created by Alex Nichol on 4/29/14.
//  Copyright (c) 2014 Alex Nichol. All rights reserved.
//

#import "ANSpreadPickerView.h"

@implementation ANSpreadPickerView

- (id)initWithFrame:(NSRect)frameRect {
  if ((self = [super initWithFrame:frameRect])) {
    [[NSBundle mainBundle] loadNibNamed:@"SpreaderViews" owner:self topLevelObjects:nil];
    [self addSubview:mainView];
    
    [self showAppropriateView];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [[NSBundle mainBundle] loadNibNamed:@"SpreaderViews" owner:self topLevelObjects:nil];
    [self addSubview:mainView];
    
    [self showAppropriateView];
  }
  return self;
}

- (void)showAppropriateView {
  if ([radialView superview]) [radialView removeFromSuperview];
  if ([rectangularView superview]) [rectangularView removeFromSuperview];
  
  if ([[popUp titleOfSelectedItem] isEqualToString:@"Rectangular"]) {
    [mainView addSubview:rectangularView];
  } else {
    [mainView addSubview:radialView];
  }
}

- (IBAction)popUpChange:(id)sender {
  [self showAppropriateView];
  [self valueChange:nil];
}

- (IBAction)valueChange:(id)sender {
  // avoid the leak warning
  ((void (*)(id, SEL))[self.target methodForSelector:self.action])(self.target, self.action);
}

- (id<FAPointSpreader>)getSpreader {
  if ([[popUp titleOfSelectedItem] isEqualToString:@"Rectangular"]) {
    FARectangularSpreader * spreader = [[FARectangularSpreader alloc] init];
    spreader.xStart = [rectStartX doubleValue];
    spreader.yStart = [rectStartY doubleValue];
    spreader.xCount = [rectSamplesX intValue];
    spreader.yCount = [rectSamplesY intValue];
    spreader.sampleWidth = [rectWidth doubleValue];
    spreader.sampleHeight = [rectHeight doubleValue];
    
    return spreader;
  } else {
    FARadialSpreader * spreader = [[FARadialSpreader alloc] init];
    spreader.radius = [radRadius doubleValue];
    spreader.rings = [radRings intValue];
    spreader.centerX = [radCenterX doubleValue];
    spreader.centerY = [radCenterX doubleValue];
    spreader.density = [radDensity intValue];
    
    return spreader;
  }
  
  return nil;
}

@end
