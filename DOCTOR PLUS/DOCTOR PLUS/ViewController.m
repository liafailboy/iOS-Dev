//
//  ViewController.m
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 5/26/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                             target:self
                                           selector:@selector(startTimer)
                                           userInfo:nil
                                            repeats:NO];
}

-(void)startTimer {
    timerForTop = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                   target:self
                                                 selector:@selector(deleteTopImage)
                                                 userInfo:nil
                                                  repeats:YES];
}

- (void)deleteTopImage {
    // set the dissolving effect of the top image from the screen
    if(top_image.alpha > 0) top_image.alpha = top_image.alpha - 0.005;
    else [timerForTop invalidate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
