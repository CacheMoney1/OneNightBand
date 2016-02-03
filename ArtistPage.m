//
//  ArtistPage.m
//  BandThing
//
//  Created by Mike Dulske on 1/23/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import "ArtistPage.h"

@interface ArtistPage() {
    @private CGFloat imageAngle;
    @private KnobViewSensor *knobSensor;
}
-(void) startKnobSensor;
@end

@implementation ArtistPage





#pragma mark - Start sensing

//KnobImage position calculation as well as determining the center point
- (void) startKnobSensor {
    // calculate center and radius of the control
    CGPoint midPoint = CGPointMake(knobImage.frame.origin.x + knobImage.frame.size.width / 2,
                                   knobImage.frame.origin.y + knobImage.frame.size.height / 2);
    CGFloat outRadius = knobImage.frame.size.width / 2;
    
    // outRadius / 4 is arbitrary, just choose something >> 0 to avoid strange
    // effects when touching the control near of it's center
    knobSensor = [[KnobViewSensor alloc] initWithMidPoint: midPoint innerRadius: outRadius / 8 outerRadius: outRadius target: self];
    [self.view addGestureRecognizer: knobSensor];
}

#pragma mark - Sensor delegate method

- (void) rotation: (CGFloat) angle
{
    // calculate rotation angle
    imageAngle += angle;
    if (imageAngle > 360)
        imageAngle -= 180;
    
    else if (imageAngle < -360)
        imageAngle += 180;
    
    // rotate image and update text field
    knobImage.transform = CGAffineTransformMakeRotation(imageAngle *  M_PI / 180);
    
}


- (void) finalAngle: (CGFloat) angle
{
    NSLog(@"Angle = %f", angle);
}

#pragma mark - View lifecycle
- (void)viewDidLoad{
    [super viewDidLoad];
    BioContainer.alpha = 1;     SkillsContainer.alpha = 0;
    PortfolioContainer.alpha = 0;
    imageAngle = MIN_ANGLE;
    [self finalAngle:imageAngle];
    [self startKnobSensor];
    CGFloat angle = [knobSensor getSensorAngle];
    if(angle <= -44.0){
        [UIView animateWithDuration:(0.5) animations:^{
            BioContainer.alpha = 1;
            SkillsContainer.alpha = 0;
            PortfolioContainer.alpha = 0;
        }];

    }
    else if(angle >= 30 && angle <= 50){
        [UIView animateWithDuration:(0.5) animations:^{
            BioContainer.alpha = 0;
            SkillsContainer.alpha = 1;
            PortfolioContainer.alpha = 0;
        }];
    }
    else if(angle >= 175){
        [UIView animateWithDuration:(0.5) animations:^{
            BioContainer.alpha = 0;
            SkillsContainer.alpha = 0;
            PortfolioContainer.alpha = 1;
        }];
    }

        
    
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return NO;
}



    /*if (!UIAccessibilityIsReduceTransparencyEnabled()) {
        self.view.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurEffectView.frame = self.view.bounds;
        blurEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self.view addSubview:blurEffectView];
        [self.view sendSubviewToBack:blurEffectView];
        [self.view sendSubviewToBack:guitarImage];
    }
    else {
        self.view.backgroundColor = [UIColor blackColor];
    }*/
    


@end
