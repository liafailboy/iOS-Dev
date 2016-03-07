//
//  ViewController.h
//  tennis
//
//  Created by Shotaro Watanabe on 5/22/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    IBOutlet UIImageView *redBar;
    IBOutlet UIImageView *blueBar;
    IBOutlet UIImageView *ball;
    UIImageView *imageToMove;
    NSTimer *timer;
    int randomNum;
    float moveX;
    float moveY;
}

@end