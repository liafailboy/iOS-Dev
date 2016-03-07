//
//  ViewController.h
//  tennis
//
//  Created by Shotaro Watanabe on 5/22/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>

@interface ViewController : UIViewController <GKSessionDelegate, GKPeerPickerControllerDelegate>{
    IBOutlet UIImageView *redBar;
    IBOutlet UIImageView *blueBar;
    IBOutlet UIImageView *ball;
    IBOutlet UIButton *connect;
    GKSession *session_;
    NSString *peerID_;
    CGPoint p;
    NSTimer *timer;
    int randomNum;
    float moveX;
    float moveY;
    BOOL firstTime;
}

@property (nonatomic, retain) GKSession *session;
@property (nonatomic, retain) NSString *peerID;

- (IBAction)connect:(id)sender;

@end