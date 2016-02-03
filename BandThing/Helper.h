//
//  Helper.h
//  BandThing
//
//  Created by Will Cobb on 2/1/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject

+ (CGFloat) distanceBetweenPointOne:(CGPoint) p1 andPointTwo: (CGPoint) p2;
+ (CGFloat) angleBetweenLineA:(CGPoint) aBegin aEnd:(CGPoint) aEnd LineB:(CGPoint) bBegin bEnd:(CGPoint) bEnd;

@end
