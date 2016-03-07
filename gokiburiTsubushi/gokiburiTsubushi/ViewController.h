//
//  ViewController.h
//  gokiburiTsubushi
//
//  Created by Shotaro Watanabe on 11/30/14.
//  Copyright (c) 2014 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ViewController : UIViewController {
    NSMutableArray *arrayOfGoki;
    NSArray *arrayOfCors;
    NSUserDefaults *defaults;
    UIImageView *objectImageView;
    UIImageView *sceneImageView;
    UIImageView *sceneTrimmedImageView;
    UILabel *labelOfCount;
    int countDead;
    BOOL isTurned;
}

- (UIImageView*)createNewGokiWithPosition:(CGPoint) point;
- (void)moveGokiToPositionWithImage:(UIImageView*) imageViewOfGoki withPosition:(CGPoint) destination withSpeed:(int) speed;

@end

