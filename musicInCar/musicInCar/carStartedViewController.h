//
//  carStartedViewController.h
//  carPlay
//
//  Created by Shotaro Watanabe on 2014/06/20.
//  Copyright (c) 2014年 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@interface carStartedViewController : UIViewController <AVAudioPlayerDelegate, CLLocationManagerDelegate>{
    NSTimer *timerForCarMove;
    NSTimer *timer;
    NSArray *arrayOfArtists;
    CLLocationManager *locMgr;
    UIImageView *carImage;
    UIImageView *tunnel;
    UIImageView *back;
    UIImageView *stateImage;
    UIImageView *tutorial;
    IBOutlet UILabel *label1;
    IBOutlet UILabel *label2;
    IBOutlet UILabel *distance;
    IBOutlet UILabel *coin;
    IBOutlet UILabel *songs;
    int speedOfCar;
    BOOL isNotMinus;
    BOOL isCalm;
    BOOL isPlaying;
    BOOL doTutorial;
    double totalDistance;
    int totalCoins;
}

@property (nonatomic, retain) CLLocationManager *locMgr;

@end
