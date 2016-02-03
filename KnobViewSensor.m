//
//  KnobViewSensor.m
//  BandThing
//
//  Created by Will Cobb on 2/1/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//
#import "KnobViewSensor.h"
#import "Helper.h"
#include <math.h>



@implementation KnobViewSensor

- (CGFloat) getSensorAngle{
    return sensorAngle;
}

-(void) setSensorAngle:(CGFloat) angle{
    sensorAngle = angle;
}
- (id) initWithMidPoint: (CGPoint) _midPoint innerRadius: (CGFloat) _innerRadius outerRadius: (CGFloat) _outerRadius target: (id <KnobViewSensorDelegate>) _target
{
    if ((self = [super initWithTarget: _target action: nil]))
    {
        midPoint    = _midPoint;
        innerRadius = _innerRadius;
        outerRadius = _outerRadius;
        target      = _target;
        cumulatedAngle = MIN_ANGLE;
    }
    return self;
}

#pragma mark - UIGestureRecognizer implementation

- (void)reset
{
    [super reset];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([touches count] != 1)
    {
        self.state = UIGestureRecognizerStateFailed;
        
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed) return;
    
    CGPoint nowPoint  = [[touches anyObject] locationInView: self.view];
    CGPoint prevPoint = [[touches anyObject] previousLocationInView: self.view];
    
    // make sure the new point is within the area
    CGFloat distance = [Helper distanceBetweenPointOne:midPoint andPointTwo:nowPoint];
    if (   innerRadius <= distance
        && distance    <= outerRadius)
    {
        // calculate rotation angle between two points
        CGFloat angle = [Helper angleBetweenLineA:midPoint aEnd:prevPoint LineB:midPoint bEnd:nowPoint];
        
        // fix value, if the 12 o'clock position is between prevPoint and nowPoint
        if (angle > 180)
        {
            angle -= 360;
        }
        else if (angle < -180)
        {
            angle += 360;
        }
        
        CGFloat checkBoundry = cumulatedAngle + angle;
        if(checkBoundry > MIN_ANGLE && checkBoundry < (MAX_ANGLE - fabs(MIN_ANGLE))) {
            // sum up single steps
            cumulatedAngle += angle;
            
            
            BOOL isClockWise;
            if (angle > 0.0) { isClockWise = YES; } else { isClockWise = NO; };
            // call delegate for rotation
            if ([target respondsToSelector: @selector(rotation:)]){
                [target rotation:angle];
            }
        }
        
    }
    else
    {
        // finger moved outside the area
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStatePossible)
    {
        self.state = UIGestureRecognizerStateRecognized;
        
        if ([target respondsToSelector: @selector(finalAngle:)])
        {
            [target finalAngle:cumulatedAngle];
        }
    }
    else
    {
        self.state = UIGestureRecognizerStateFailed;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    self.state = UIGestureRecognizerStateFailed;
}

@end
