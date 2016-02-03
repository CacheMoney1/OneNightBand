//
//  ArtistPage.h
//  BandThing
//
//  Created by Mike Dulske on 1/23/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KnobViewSensor.h"



@interface ArtistPage : UIViewController<KnobViewSensorDelegate>{
    IBOutlet UIImageView *knobImage;
    IBOutlet UIView *BioContainer;
    IBOutlet UIView *SkillsContainer;
    IBOutlet UIView *PortfolioContainer;
    
   
    
    
}

    
    

@end
