//
//  hundredDayViewController.m
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 5/27/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import "hundredDayViewController.h"

@interface hundredDayViewController ()

@end

@implementation hundredDayViewController

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
    [self loadViewManually];
}

- (void)loadViewManually {
    
    // initialize NSUserdefaults and arrays for pictures
    defaults = [NSUserDefaults standardUserDefaults];
    if (nil == [defaults objectForKey:@"recordArray"]) {
        arrayOfRecord = [[NSMutableArray alloc] init];
        [arrayOfRecord addObject:[NSNumber numberWithInteger:0]];
        [arrayOfRecord addObject:[NSNumber numberWithInteger:8]];
        [arrayOfRecord addObject:[NSNumber numberWithInteger:29]];
        [arrayOfRecord addObject:[NSNumber numberWithInteger:86]];
        [arrayOfRecord addObject:[NSNumber numberWithInteger:87]];
        [arrayOfRecord addObject:[NSNumber numberWithInteger:88]];
        [arrayOfRecord addObject:[NSNumber numberWithInteger:92]];
    } else {
        arrayOfRecord = [defaults objectForKey:@"recordArray"];
    }
    for (int i = 0; i < 100; i++) {
        NSUInteger check = [arrayOfRecord indexOfObject:[NSNumber numberWithInteger:i]];
        
        if (check == NSNotFound) {
            int num1 = i / 10;
            int num2 = i;
            
            float yCor = num1 * 45 + 53;
            while (num2 > 9) {
                num2 = num2 - 10;
            }
            float xCor = num2 * 32;
            UIView *viewToHide = [[UIView alloc] initWithFrame:CGRectMake(xCor, yCor, 32, 45)];
            viewToHide.backgroundColor = [UIColor blackColor];
            viewToHide.alpha = 0.85;
            [self.view addSubview:viewToHide];
        }
    }
}

- (IBAction)todayTraining:(id)sender {
    if ([[button currentTitle] isEqual:@"Done!"]) {
        [imageView removeFromSuperview];
        [self.view addSubview:list];
        [self loadViewManually];
        button.enabled = NO;
    } else {
        for (int i = 0; i < 10000000; i++) {
            NSString *picName;
            int num = arc4random() % 100;
            NSUInteger check = [arrayOfRecord indexOfObject:[NSNumber numberWithInteger:num]];
            if (check == NSNotFound) {
                if (num <= 24) {
                    picName = [NSString stringWithFormat:@"d+100_A-%02d.png", num + 1];
                } else if (num <= 44) {
                    picName = [NSString stringWithFormat:@"d+100_B-%02d.png", num - 24];
                } else if (num <= 69) {
                    picName = [NSString stringWithFormat:@"d+100_C-%02d.png", num - 44];
                } else if (num <= 94) {
                    picName = [NSString stringWithFormat:@"d+100_D-%02d.png", num - 69];
                } else {
                    picName = [NSString stringWithFormat:@"d+100_E-%02d.png", num - 94];
                }
                [arrayOfRecord addObject:[NSNumber numberWithInteger:num]];
                [defaults setObject:arrayOfRecord forKey:@"recordArray"];
                imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:picName]];
                imageView.frame = CGRectMake(0, 51, 320, 475);
                [self.view addSubview:imageView];
                [button setTitle:@"Done!" forState:UIControlStateNormal];
                [self.view addSubview:button];
                break;
            }
        }
    }
}

// when done the daily activity
// [arrayOfRecord addObject:[NSNumber numberWithInteger:INDEX]];
// start from zero

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
