//
//  ViewController.m
//  BandThing
//
//  Created by Will Cobb on 1/22/16.
//  Copyright © 2016 Will Cobb. All rights reserved.
//

#import "GuitarNeckView.h"
#import "ONBGuitarButton.h"
#import "ONBSession.h"

@interface ViewController () {
    CGPoint         firstTouch;
    NSMutableArray *viewPins;
    CGFloat         scrollOffset;
    ONBGuitarButton *_currentButton;
}

@end

#define kFretY 383

//200 -


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.clipsToBounds = YES;
    
    //navBarHairlineImageView = [self findHairlineImageViewUnder: navigationBar];
    
    //[[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;

    UIImage* artistPageImage = [UIImage imageNamed:@"Thomasface.png"];
    CGRect frameing = CGRectMake(0, 0, artistPageImage.size.width, artistPageImage.size.height);
    UIButton *artistPageButton = [[UIButton alloc] initWithFrame:frameing];
    artistPageButton.layer.cornerRadius = artistPageButton.frame.size.width/2;
    artistPageButton.clipsToBounds = YES;
    [artistPageButton setBackgroundImage:artistPageImage forState:UIControlStateNormal];
    [artistPageButton addTarget: self action:@selector(goToArtist)
               forControlEvents:UIControlEventTouchUpInside];
    [artistPageButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *artistButton = [[UIBarButtonItem alloc] initWithCustomView:artistPageButton];
    self.navigationItem.leftBarButtonItem = artistButton;
    //UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithImage: [UIImage imageNamed:@"Thomasface.png"] style:UIBarButtonItemStylePlain target: self action:@selector(editObject:)];
    //self.navigationItem.leftBarButtonItem = editButton;
    
    //UITapGestureRecognizer *singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarger:self action:@selector(handleSingleTap:)];
    //[self.view addGestureRecognizer:singleFingerTap];
    
    
    
    scrollOffset = 0;
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = infoView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor], (id)[[UIColor blackColor] CGColor], (id)[[UIColor blackColor] CGColor], nil];
    [infoView.layer insertSublayer:gradient atIndex:0];
    
    NSArray *randomSessionNames = @[@"Garage Jam Session", @"Basement Guitar and Drums", @"90s Songs Session", @"80s Songs Session", @"Playing 70s Hits"];
    NSArray *randomSessionPics = @[[UIImage imageNamed:@"images-1.jpg" ],[UIImage imageNamed:@"images-2.jpg"],[UIImage imageNamed:@"images.jpg"],[UIImage imageNamed:@"imgres-1.jpg"],[UIImage imageNamed:@"imgres-2.jpg"]];
    viewPins = [NSMutableArray new];
    
    for (int i = -27; i < 7; i++) {
        ONBGuitarButton *button = [[ONBGuitarButton alloc] initWithLane:arc4random_uniform(6)];
        [button setYPosition:i * 2.3];
        [self.view addSubview:button];
        [viewPins addObject:button];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToPin:)];
        tap.numberOfTapsRequired = 1;
        [button addGestureRecognizer:tap];
        button.userInteractionEnabled = YES;
        
        
        ONBSession *session = [[ONBSession alloc] init];
        session.name = randomSessionNames[arc4random_uniform((uint32_t)randomSessionNames.count)];
        session.views = arc4random_uniform(50) * arc4random_uniform(50);
        session.sessPic = randomSessionPics[arc4random_uniform((uint32_t)randomSessionPics.count)];//[UIrImage imageNamed:@"images-1.jpg" ];
        
        button.session = session;
    }
    
    [self displaySessionInfo];
    
}

- (void)goToArtist
{
    [self performSegueWithIdentifier:@"ToArtist" sender:self];
}


- (void)scrollToPin:(UITapGestureRecognizer *)sender
{
    ONBGuitarButton *button = (ONBGuitarButton *)sender.view;
    CGFloat scrollDistance = 13 - sqrt(button.center.y - 200) ;
    [UIView animateWithDuration:0.3 animations:^{
        for (ONBGuitarButton *button in viewPins) {
            [button offsetYPosition:scrollDistance];
            scrollOffset += scrollDistance;
        }
    } completion:^(BOOL finished) {
        [self displaySessionInfo];
    }];
}

- (void)goToSession:(UILongPressGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"UIGestureRecognizerStateBegan");
        [self performSegueWithIdentifier:@"ToSession" sender:self];
    } else if (sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"UIGestureRecognizerStateEnded");
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)displaySessionInfo
{
    ONBGuitarButton *currentButton = [self currentButton];
    opacityView.alpha = MAX(0, MIN(3 - (fabs(currentButton.center.y - kFretY) * 0.15), 1));
    ONBSession      *currentSession = currentButton.session;
    sessionName.text = currentSession.name;
    sessionViews.text = [NSString stringWithFormat:@"%ld", (long)currentSession.views];
    sessionPic.image = currentSession.sessPic;
}

- (ONBGuitarButton *)currentButton
{
    //return viewPins[MAX(0, MIN((int)(scrollOffset / 60), viewPins.count-1))];
    ONBGuitarButton *closest = viewPins[0];
    for (ONBGuitarButton *button in viewPins) {
        if (fabs(button.center.y - kFretY) < (fabs(closest.center.y - kFretY))) {
            closest = button;
        }
    }
    if (_currentButton && _currentButton != closest) {
        _currentButton.isDiplayedButton = NO;
    }
    closest.isDiplayedButton = YES;
    _currentButton = closest;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(goToSession:)];
    longPress.minimumPressDuration = 1.2;
    [_currentButton addGestureRecognizer:longPress];
    return closest;
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    firstTouch = [t locationInView:self.view];
    firstTouch.y /= 15;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    CGPoint nextTouch = [t locationInView:self.view];
    nextTouch.y /= 15;
    for (ONBGuitarButton *button in viewPins) {
        [button offsetYPosition:nextTouch.y - firstTouch.y];
        scrollOffset += nextTouch.y - firstTouch.y;
    }
    firstTouch = nextTouch;
    [self displaySessionInfo];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


@end
