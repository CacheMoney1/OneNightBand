//
//  ONBGuitarButton.h
//  BandThing
//
//  Created by Will Cobb on 1/22/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ONBSession;
@interface ONBGuitarButton : UIImageView <UIGestureRecognizerDelegate>

@property NSInteger     lane;
@property NSString      *sessionName;
@property ONBSession    *session;
@property (nonatomic) BOOL isDiplayedButton;
@property NSObject      *tap;

- (id)initWithLane:(NSInteger)lane;
- (void)setYPosition:(CGFloat)position;
- (void)offsetYPosition:(CGFloat)offset;

@end