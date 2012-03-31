//
//  ViewController.h
//  TouchyTennis
//
//  Created by AJ Austinson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#import "GameObject.h"

@interface ViewController : UIViewController {
    GameObject *paddle1;
    GameObject *paddle2;
    GameObject *ball;
    CGPoint ballVelocity;
    UILabel *score;
    int score1, score2;
}

- (void)resetBall;

@end
