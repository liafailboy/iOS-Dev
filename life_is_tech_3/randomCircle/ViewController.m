//
//  ViewController.m
//  randomCircle
//
//  Created by Shotaro Watanabe on 5/23/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    Board *board = [[Board alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:board];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
