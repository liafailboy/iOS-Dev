//
//  ViewController.h
//  sensha
//
//  Created by Shotaro Watanabe on 11/30/14.
//  Copyright (c) 2014 liafailboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    NSMutableArray *arrayOfSensha;
    NSMutableArray *arrayOfTama;
    UIImageView *selfSenshaImageView;
    int score;
}

- (void)createNewSenshaWithPosition:(CGPoint) point withString:(NSString*)string;
- (void)moveSenshaToPositionWithImage:(UIImageView*) imageViewOfSensha withPosition:(CGPoint) destination withSpeed:(int) speed;

@end

