//
//  ViewController.m
//  TouchyTennis
//
//  Created by AJ Austinson on 3/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define STARTING_BALL_SPEED 6
#define MAX_BALL_FACTOR 20
#define BALL_SPEED_INCREASE 1.1

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    paddle1 = [GameObject layer];
    paddle1.bounds = CGRectMake(0, 0, 40, 160);
    paddle1.backgroundColor = [UIColor whiteColor].CGColor;
    paddle1.position = CGPointMake(40, 386);
    [self.view.layer addSublayer:paddle1];
    
    paddle2 = [GameObject layer];
    paddle2.bounds = CGRectMake(0, 0, 40, 160);
    paddle2.position = CGPointMake(1024-40, 386);
    paddle2.backgroundColor = [UIColor whiteColor].CGColor;
    [self.view.layer addSublayer:paddle2];
    
    ball = [GameObject layer];
    ball.bounds = CGRectMake(0, 0, 40, 40);
    ball.position = CGPointMake(512, 386);
    ball.backgroundColor = [UIColor whiteColor].CGColor;
    ball.cornerRadius = 20;
    [self.view.layer addSublayer:ball];
    
    score = [[UILabel alloc] initWithFrame:CGRectMake(512-100, 15, 200, 40)];
    score.backgroundColor = [UIColor clearColor];
    score.textColor = [UIColor whiteColor];
    score.textAlignment = UITextAlignmentCenter;
    score.font = [UIFont fontWithName:@"ArialRoundedMTBold" size:24];
    score.text = @"0 | 0";
    [self.view addSubview:score];
    
    UIView *paddle1Area = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 512, 768)];
    paddle1Area.backgroundColor = [UIColor clearColor];
    [self.view addSubview:paddle1Area];
    
    UIView *paddle2Area = [[UIView alloc] initWithFrame:CGRectMake(512, 0, 512, 768)];
    paddle2Area.backgroundColor = [UIColor clearColor];
    [self.view addSubview:paddle2Area];
    
    UIPanGestureRecognizer *pan1 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan1:)];
    [paddle1Area addGestureRecognizer:pan1];
    
    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPan2:)];
    [paddle2Area addGestureRecognizer:pan2];
    
    CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(update:)];
    displayLink.frameInterval = 1;
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    ballVelocity = CGPointMake(STARTING_BALL_SPEED, 0);
    score1 = 0;
    score2 = 0;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

// --

- (void)onPan1:(UIPanGestureRecognizer *)pan {
    paddle1.position = CGPointMake(40, [pan locationInView:self.view].y);
}

- (void)onPan2:(UIPanGestureRecognizer *)pan {
    paddle2.position = CGPointMake(1024-40, [pan locationInView:self.view].y);
}

- (void)update:(CADisplayLink *)displayLink {
    if( ball.opacity < 1 ){
        ball.opacity += 0.01;
        return;
    }
    
    ball.position = CGPointMake(ball.position.x + ballVelocity.x, ball.position.y + ballVelocity.y);    
    
    if( ball.position.x < 80 ){
        if( ball.position.y > paddle1.position.y - 80 && ball.position.y < paddle1.position.y + 80 ){
            if(abs(ballVelocity.x) < MAX_BALL_FACTOR) ballVelocity.x *= -BALL_SPEED_INCREASE;
            else ballVelocity.x *= -1;
            ballVelocity.y = ( ball.position.y - paddle1.position.y ) * 0.05;
        }
        else {
            //score
            score2 += 1;
            score.text = [NSString stringWithFormat:@"%i | %i", score1, score2];
            [self resetBall];
        }
    }
    else if( ball.position.x > 1024-80 ){
        if( ball.position.y > paddle2.position.y - 80 && ball.position.y < paddle2.position.y + 80 ){            
            if(abs(ballVelocity.x) < MAX_BALL_FACTOR) ballVelocity.x *= -BALL_SPEED_INCREASE;
            else ballVelocity.x *= -1;
            ballVelocity.y = ( ball.position.y - paddle2.position.y ) * 0.05;
        }
        else {
            //score
            score1 += 1;
            score.text = [NSString stringWithFormat:@"%i | %i", score1, score2];
            [self resetBall];
        }
    }
    
    if( ball.position.y < 20 || ball.position.y > 768 - 20 )
        ballVelocity.y *= -1;
}

- (void)resetBall {
    ballVelocity = CGPointMake(rand() % 10 < 5 ? -STARTING_BALL_SPEED : STARTING_BALL_SPEED, 0);
    ball.position = CGPointMake(512, 384);
    ball.opacity = 0;
}

@end
