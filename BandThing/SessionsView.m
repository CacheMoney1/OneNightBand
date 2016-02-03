//
//  SessionsView.m
//  BandThing
//
//  Created by Mike Dulske on 1/23/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import "SessionsView.h"

@implementation SessionsView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    
    CGAffineTransform trans = CGAffineTransformMakeRotation(M_PI_2);
    //slider.transform = trans;
    
    
}

@end
