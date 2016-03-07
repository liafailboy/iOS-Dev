//
//  ViewController.h
//  musicInCar
//
//  Created by Shotaro Watanabe on 2014/06/28.
//  Copyright (c) 2014年 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "carStartedViewController.h"

@interface ViewController : UIViewController {
    IBOutlet UIImageView *carImageView;
    IBOutlet UIView *view;
    NSTimer *timerForUpDown;
    NSTimer *timerForMove;
    NSTimer *tiemrForNextView;
    BOOL isPlus;
    int speed;
}

- (IBAction)start:(id)sender;

@end
