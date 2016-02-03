//
//  ONBGuitarButton.m
//  BandThing
//
//  Created by Will Cobb on 1/22/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import "ONBGuitarButton.h"
#import "ONBSession.h"
#define kStartY 200
#define kMaxY 12.5

@interface ONBGuitarButton () {
    CGFloat _yPosition;
    CGFloat _slope;
    CGFloat _baseX;
    
}

@end

@implementation ONBGuitarButton

- (id)initWithLane:(NSInteger)lane
{
    if (self = [super initWithFrame:CGRectZero]) {
        self.lane = lane;
        self.isDiplayedButton = NO;
        self.tintColor = [UIColor redColor];
        self.image = [UIImage imageNamed:@"GuitarPin_Red.png"];
        switch (self.lane) {
            case 0:
                _baseX = 155;
                _slope = -0.85;
                break;
            case 1:
                _baseX = 167;
                _slope = -.53;
                break;
            case 2:
                _baseX = 181;
                _slope = -0.2;
                break;
            case 3:
                _baseX = 195;
                _slope = 0.14;
                break;
            case 4:
                _baseX = 210;
                _slope = 0.47;
                break;
            case 5:
                _baseX = 227;
                _slope = 0.83;
                break;
            default:
                break;
        }
    }
    return self;
}

- (void)setYPosition:(CGFloat)yPosition
{
    _yPosition = yPosition;
    if (yPosition < 1) {
        yPosition = 1;
        self.alpha = 0;
        //_yPosition = yPosition;
        //return;
    }
    CGFloat size = powf(yPosition, 1.5) + 10;
    self.frame = CGRectMake(0, 0, size, size);
    //self.center = CGPointMake(yPosition * 5.0 * _slope + _baseX, yPosition * 5.0 + kStartY);
    self.center = CGPointMake(powf(yPosition, 2) * _slope + _baseX, powf(yPosition, 2) + kStartY);
    
    //Intro fade
    if (yPosition < 8)
        self.alpha = MIN(1, (yPosition - 1) * 0.2);
    if (yPosition > 10) //Trailing Fade
        self.alpha = MIN(1, MAX(0, 1 - (yPosition - kMaxY) * 0.5));
    
}

- (void)setIsDiplayedButton:(BOOL)isDiplayedButton
{
    if (isDiplayedButton == _isDiplayedButton)
        return;
    if (isDiplayedButton)
        self.image = [UIImage imageNamed:@"GuitarPin_Green.png"];
    else
        self.image = [UIImage imageNamed:@"GuitarPin_Red.png"];
    _isDiplayedButton = isDiplayedButton;
}

- (void)offsetYPosition:(CGFloat)offset
{
    [self setYPosition:_yPosition + offset];
    
}

@end
