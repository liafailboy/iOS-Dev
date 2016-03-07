//
//  myPaceChooseViewController.m
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 5/27/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import "myPaceChooseViewController.h"

@interface myPaceChooseViewController ()

@end

@implementation myPaceChooseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)pushedA:(id)sender {
    whichAlp = 0;
    [self performSegueWithIdentifier:@"goToDetailView" sender:nil];
}

-(IBAction)pushedB:(id)sender {
    whichAlp = 1;
    [self performSegueWithIdentifier:@"goToDetailView" sender:nil];
}

-(IBAction)pushedC:(id)sender {
    whichAlp = 2;
    [self performSegueWithIdentifier:@"goToDetailView" sender:nil];
}

-(IBAction)pushedD:(id)sender {
    whichAlp = 3;
    [self performSegueWithIdentifier:@"goToDetailView" sender:nil];
}

-(IBAction)pushedE:(id)sender {
    whichAlp = 4;
    [self performSegueWithIdentifier:@"goToDetailView" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
