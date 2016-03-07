//
//  hundredDayViewController.h
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 5/27/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hundredDayViewController : UIViewController {
    NSMutableArray *arrayOfRecord;
    NSUserDefaults *defaults;
    UIImageView *imageView;
    IBOutlet UIImageView *list;
    IBOutlet UIButton *button;
}

-(IBAction)todayTraining:(id)sender;

@end
