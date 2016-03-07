//
//  ViewController.h
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 5/26/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    // image of top menu
    IBOutlet UIImageView *top_image;
    
    // set timer for dissolving effect for the image
    NSTimer *timer;
    NSTimer *timerForTop;
}

@end
