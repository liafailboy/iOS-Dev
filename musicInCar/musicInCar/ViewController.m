//
//  ViewController.m
//  musicInCar
//
//  Created by Shotaro Watanabe on 2014/06/28.
//  Copyright (c) 2014年 liafailboy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    timerForUpDown = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                      target:self
                                                    selector:@selector(carUpDown)
                                                    userInfo:nil
                                                     repeats:YES];
    isPlus = YES;
    speed = 1;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)carUpDown {
    if (carImageView.center.x >= 500) [timerForUpDown invalidate];
    if (isPlus) {
        carImageView.center = CGPointMake(carImageView.center.x, carImageView.center.y + 3);
        isPlus = NO;
    } else {
        carImageView.center = CGPointMake(carImageView.center.x, carImageView.center.y - 3);
        isPlus = YES;
    }
}

- (IBAction)start:(id)sender {
    timerForMove = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                    target:self
                                                  selector:@selector(carMove)
                                                  userInfo:nil
                                                   repeats:YES];
}

- (void)carMove {
    if (carImageView.center.x >= 800){
        [timerForMove invalidate];
        carStartedViewController *viewController = [[carStartedViewController alloc] initWithNibName:@"carStartedViewController" bundle:nil];
        [self.view addSubview:viewController.view];
    }
    speed = speed + 5;
    carImageView.center = CGPointMake(carImageView.center.x + speed, carImageView.center.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
