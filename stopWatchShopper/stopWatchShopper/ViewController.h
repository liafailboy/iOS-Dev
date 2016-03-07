//
//  ViewController.h
//  stopWatchShopper
//
//  Created by Shotaro Watanabe on 4/24/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController {
    IBOutlet UILabel *totalTime;
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UIButton *button;
    IBOutlet UIButton *nextButton;
    NSTimer *timer;
    double total;
    int labelCount;
    NSMutableArray *mutableArray;
}

-(IBAction)startStopTimer:(id)sender;
-(IBAction)next:(id)sender;


@end
