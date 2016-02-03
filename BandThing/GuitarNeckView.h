//
//  ViewController.h
//  BandThing
//
//  Created by Will Cobb on 1/22/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIGestureRecognizerDelegate> {
    IBOutlet UIImageView    *guitarImage;
    IBOutlet UIView         *infoView;
    
    IBOutlet UIView         *opacityView;
    IBOutlet UILabel        *sessionName;
    IBOutlet UILabel        *sessionViews;
    IBOutlet UIImageView     *sessionPic;
    
}


@end

