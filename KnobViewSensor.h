//
//  KnobViewSensor.h
//  BandThing
//
//  Created by Will Cobb on 2/1/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>

//Set the minium and Maximum rotation
#define MIN_ANGLE -45.0
#define MAX_ANGLE 180.0


@protocol KnobViewSensorDelegate <UIGestureRecognizerDelegate>
@optional
- (void) rotation: (CGFloat) angle;
- (void) finalAngle:(CGFloat) cumulatedAngle;





@end

//CGFloat sensorAngle; //caused no build

@interface KnobViewSensor : UIGestureRecognizer {
    CGPoint midPoint;
    CGFloat innerRadius;
    CGFloat outerRadius;
    CGFloat cumulatedAngle;
    CGFloat sensorAngle;
    id <KnobViewSensorDelegate> target;
}



- (id) initWithMidPoint: (CGPoint) midPoint innerRadius: (CGFloat) innerRadius outerRadius: (CGFloat) outerRadius target: (id) target;

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

- (void) setSensorAngle:(CGFloat) angle;
- (CGFloat) getSensorAngle;

@end
