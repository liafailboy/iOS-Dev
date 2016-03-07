//
//  ViewController.m
//  stopWatchShopper
//
//  Created by Shotaro Watanabe on 4/24/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (IBAction)startStopTimer:(id)sender {
    if (timer == nil) {
        timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                             target:self
                                           selector:@selector(countTime)
                                           userInfo:nil
                                            repeats:YES];
        [button setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
        [timer invalidate];
        timer = nil;
        [button setTitle:@"Start" forState:UIControlStateNormal];
    }
}

- (void)countTime {
    total = total + 0.01;
    totalTime.text = [NSString stringWithFormat:@"%.2f", total];
}

- (void)volumeDidChange {
    if ([mutableArray count] == 0) {
        label2.text = [totalTime text];
    }
    [mutableArray addObject:[NSNumber numberWithDouble:[[totalTime text] doubleValue]]];
    nextButton.hidden = NO;
}

-(IBAction)next:(id)sender {
    if ([mutableArray count] <= labelCount) {
        labelCount = 0;
        label2.text = [NSString stringWithFormat:@"%.2f", [[mutableArray objectAtIndex:labelCount] doubleValue]];
    } else {
        label2.text = [NSString stringWithFormat:@"%.2f", [[mutableArray objectAtIndex:labelCount] doubleValue] - [[mutableArray objectAtIndex:labelCount-1] doubleValue]];
    }
    label1.text = [NSString stringWithFormat:@"%d番目", labelCount + 1];
    labelCount++;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    total = 0;
    labelCount = 1;
    timer = nil;
    mutableArray = [[NSMutableArray alloc] init];
    nextButton.hidden = YES;
    
    MPVolumeView *volumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(18, 340, 284, 23)];
    [self.view addSubview:volumeView];
    volumeView.hidden = YES;
    [NSNotificationCenter.defaultCenter
     addObserver:self
     selector:@selector(volumeDidChange)
     name:@"AVSystemController_SystemVolumeDidChangeNotification"
     object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
