//
//  ViewController.m
//  gokiburiTsubushi
//
//  Created by Shotaro Watanabe on 11/30/14.
//  Copyright (c) 2014 liafailboy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

AVAudioPlayer *audioPlayer_;
UISlider *slider_;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrayOfGoki = [[NSMutableArray alloc] init];
    isTurned = NO;
    defaults = [NSUserDefaults standardUserDefaults];
    
    countDead = 0;
    
    switch (arc4random()%4) {
        case 0:
            [defaults setObject:@"bath" forKey:@"scene"];
            break;
        case 1:
            [defaults setObject:@"kyoushitsu" forKey:@"scene"];
            break;
        case 2:
            [defaults setObject:@"kitchen" forKey:@"scene"];
            break;
        case 3:
            [defaults setObject:@"train" forKey:@"scene"];
            break;
        default:
            break;
    }
    
    [defaults setObject:@"ashi" forKey:@"object"];

    objectImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [defaults objectForKey:@"object"]]]];
    
    sceneImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png", [defaults objectForKey:@"scene"]]]];
    
    sceneTrimmedImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_trimmed.png", [defaults objectForKey:@"scene"]]]];
    
    sceneImageView.frame = CGRectMake(0, 0, 320, 568);
    sceneTrimmedImageView.frame = CGRectMake(0, 0, 320, 568);
    
    labelOfCount = [[UILabel alloc] initWithFrame:CGRectMake(9,485,100,50)];
    labelOfCount.font =  [UIFont fontWithName:@"Helvetica Neue" size:26];
    labelOfCount.text = @"0";
    labelOfCount.textColor = [UIColor whiteColor];
    
    [self.view addSubview:sceneImageView];
    [self.view addSubview:sceneTrimmedImageView];
    [self.view addSubview:labelOfCount];
    
    NSString *filepath;
    
    if ([[defaults objectForKey:@"scene"] isEqualToString:@"bath"]) {
        filepath = [[NSBundle mainBundle] pathForResource:@"01" ofType:@"txt"];
    } else if ([[defaults objectForKey:@"scene"] isEqualToString:@"kitchen"]) {
        filepath = [[NSBundle mainBundle] pathForResource:@"02" ofType:@"txt"];
    } else if ([[defaults objectForKey:@"scene"] isEqualToString:@"kyoushitsu"]) {
        filepath = [[NSBundle mainBundle] pathForResource:@"03" ofType:@"txt"];
    } else {
        filepath = [[NSBundle mainBundle] pathForResource:@"04" ofType:@"txt"];
    }
    
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error) NSLog(@"Error reading file: %@", error.localizedDescription);
    arrayOfCors = [fileContents componentsSeparatedByString:@"\n"];
    
    NSTimer *timerForAlways = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                      target:self
                                                    selector:@selector(timerForAlways)
                                                    userInfo:nil
                                                     repeats:YES];
    
    NSTimer *timerForGoki = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                               target:self
                                                             selector:@selector(timerForGoki)
                                                             userInfo:nil
                                                              repeats:YES];
    
    NSBundle *mainBundle = [NSBundle mainBundle];
    NSString *filePath = [mainBundle pathForResource:@"goki" ofType:@"mp3"];
    NSURL *fileUrl  = [NSURL fileURLWithPath:filePath];
    
    error = nil;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    if(!error) {
        [audioPlayer prepareToPlay];
        audioPlayer_ = audioPlayer;
    } else {
        NSLog(@"AVAudioPlayer Error");
    }
}

- (void)timerForGoki {
    int randomNum = arc4random()%28;
    int randomSpeed = arc4random()%3 + 1;
    NSArray* array;
    if (randomNum < 7) {
        array = [[arrayOfCors objectAtIndex:randomNum] componentsSeparatedByString:@","];
        UIImageView *imageView = [self createNewGokiWithPosition:CGPointMake([[array objectAtIndex:0] intValue], [[array objectAtIndex:1] intValue])];
        [self moveGokiToPositionWithImage:imageView withPosition: CGPointMake([[array objectAtIndex:2] intValue], [[array objectAtIndex:3] intValue]) withSpeed:randomSpeed];
    }
    
}

- (void)timerForAlways {
    for (int i  = 0; i < [arrayOfGoki count]; i++) {
        if (isTurned) {
            UIImageView *imageViewOfGoki = [arrayOfGoki objectAtIndex:i];
            imageViewOfGoki.transform = CGAffineTransformMakeRotation(0.05235987755982988);
            isTurned = NO;
        } else {
            UIImageView *imageViewOfGoki = [arrayOfGoki objectAtIndex:i];
            imageViewOfGoki.transform = CGAffineTransformMakeRotation(-0.05235987755982988);
            isTurned = YES;
        }
    }
}

- (UIImageView*)createNewGokiWithPosition:(CGPoint) point {
    
    // create new image view of goki and add it to the main window
    UIImageView *imageViewOfGoki = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gokiburi.png"]];
    imageViewOfGoki.frame = CGRectMake(point.x, point.y, 31, 26);
    imageViewOfGoki.userInteractionEnabled = YES;
    [arrayOfGoki addObject:imageViewOfGoki];
    [self.view addSubview:imageViewOfGoki];
    [self.view bringSubviewToFront:sceneTrimmedImageView];
    [self.view bringSubviewToFront:labelOfCount];
    return imageViewOfGoki;
}

- (void)moveGokiToPositionWithImage:(UIImageView *)imageViewOfGoki withPosition:(CGPoint)destination withSpeed:(int)speed {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:imageViewOfGoki, @"imageOfGoki", [NSValue valueWithCGPoint:destination], @"destination", [NSNumber numberWithInt:speed], @"speed", nil];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                      target:self
                                                    selector:@selector(timerToMoveGoki:)
                                                    userInfo:dictionary
                                                     repeats:YES];
}

- (void)timerToMoveGoki:(NSTimer*)timer {
    UIImageView *imageViewOfGoki = [[timer userInfo] objectForKey:@"imageOfGoki"];
    CGPoint destination = [[[timer userInfo] objectForKey:@"destination"] CGPointValue];
    int locationX = (int)(imageViewOfGoki.center.x);
    int locationY = (int)(imageViewOfGoki.center.y);
    int speed = [[[timer userInfo] objectForKey:@"speed"] intValue];
    
    if (destination.x == locationX) {
    } else if (destination.x > locationX) {
        locationX = locationX + speed;
    } else {
        locationX = locationX - speed;
    }
    
    if (destination.y == locationY) {
    } else if (destination.y > locationY) {
        locationY = locationY + speed;
    } else {
        locationY = locationY - speed;
    }
    
    imageViewOfGoki.center = CGPointMake(locationX, locationY);
    
    if (destination.x - locationX < 3 && destination.y - locationY < 3) {
        [imageViewOfGoki removeFromSuperview];
        [timer invalidate];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    for (int i = 0; i < [arrayOfGoki count]; i++) {
        UIImageView *imageView = [arrayOfGoki objectAtIndex:i];
        if ([touch view] == imageView) {
            UIImageView *gokiburiDead = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:[UIImage imageNamed:@"gokiburi.png"].CGImage
                                                                                               scale:[UIImage imageNamed:@"gokiburi.png"].scale
                                                                                         orientation:UIImageOrientationDownMirrored]];
            gokiburiDead.frame = CGRectMake(100, 100, 31, 26);
            gokiburiDead.center = imageView.center;
            [imageView removeFromSuperview];
            [self.view addSubview:gokiburiDead];
            [self.view bringSubviewToFront:sceneTrimmedImageView];
            [self.view bringSubviewToFront:labelOfCount];
            countDead++;
            labelOfCount.text = [NSString stringWithFormat:@"%d", countDead];
            [audioPlayer_ play];
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
