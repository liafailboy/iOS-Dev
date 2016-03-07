//
//  ViewController.m
//  sensha
//
//  Created by Shotaro Watanabe on 11/30/14.
//  Copyright (c) 2014 liafailboy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrayOfSensha = [[NSMutableArray alloc] init];
    arrayOfTama = [[NSMutableArray alloc] init];
    
    score = 0;
    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]];
    background.frame = CGRectMake(0, 0, 320, 568);
    [self.view addSubview:background];
    
    selfSenshaImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sensha.png"]];
    selfSenshaImageView.userInteractionEnabled = YES;
    selfSenshaImageView.frame = CGRectMake(140, 482, 40, 56);
    [self.view addSubview:selfSenshaImageView];
    
    NSTimer *timerForTama = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                             target:self
                                                           selector:@selector(timerToTama:)
                                                           userInfo:nil
                                                            repeats:YES];
    
    for (int j = 0; j < 12; j++) {
        NSString *filepath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"0%d", arc4random()%5 + 1] ofType:@"txt"];
        NSError *error;
        NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
        
        if (error) NSLog(@"Error reading file: %@", error.localizedDescription);
        NSArray *arrayOfCor = [fileContents componentsSeparatedByString:@"\n"];
        
        for (int i = 0; i < [arrayOfCor count]; i++) {
            NSArray* array = [[arrayOfCor objectAtIndex:i] componentsSeparatedByString:@","];
            [self createNewSenshaWithPosition:CGPointMake([[array objectAtIndex:1] intValue],[[array objectAtIndex:2] intValue]- j * 568) withString:[array objectAtIndex:0]];
        }
    }
    
    for (int i = 0; i < [arrayOfSensha count]; i++) {
        UIImageView *imageView = [arrayOfSensha objectAtIndex:i];
        [self moveSenshaToPositionWithImage:imageView withPosition:CGPointMake(imageView.center.x, 650) withSpeed:2];
    }
}

- (void)timerToTama:(NSTimer*)timer {
    UIImageView *tama = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tama.png"]];
    tama.frame = CGRectMake(selfSenshaImageView.center.x, selfSenshaImageView.center.y, 2, 3);
    [arrayOfTama addObject:tama];
    for (int i = 0; i < [arrayOfTama count]; i++) {
        UIImageView *imageView = [arrayOfTama objectAtIndex:i];
        imageView.center = CGPointMake(imageView.center.x, selfSenshaImageView.center.y -  ([arrayOfTama count]-i) * 20);
    }
    [self.view addSubview:tama];
}

- (void)createNewSenshaWithPosition:(CGPoint)point withString:(NSString *)string {
    // create new image view of sensha and add it to the main window
    NSString *nameOfSensha;
    CGFloat xCor;
    CGFloat yCor;
    if ([string isEqualToString:@"r"]) {
        nameOfSensha = @"sensha_small.png";
        xCor = 40;
        yCor = 51;
    } else if ([string isEqualToString:@"o"]) {
        nameOfSensha = @"sensha_big.png";
        xCor = 63;
        yCor = 71;
    } else if ([string isEqualToString:@"u"]) {
        nameOfSensha = @"ufo.png";
        xCor = 40;
        yCor = 22;
    } else {
        nameOfSensha = @"heli.png";
        xCor = 40;
        yCor = 33;
    }
    UIImageView *imageViewOfSensha = [[UIImageView alloc] initWithImage:[UIImage imageNamed:nameOfSensha]];
    imageViewOfSensha.frame = CGRectMake(point.x, point.y, xCor, yCor);
    imageViewOfSensha.userInteractionEnabled = YES;
    [arrayOfSensha addObject:imageViewOfSensha];
    [self.view addSubview:imageViewOfSensha];
}
- (void)moveSenshaToPositionWithImage:(UIImageView *)imageViewOfSensha withPosition:(CGPoint)destination withSpeed:(int)speed {
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:imageViewOfSensha, @"imageOfSensha", [NSValue valueWithCGPoint:destination], @"destination", [NSNumber numberWithInt:speed], @"speed", nil];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                      target:self
                                                    selector:@selector(timerToMoveSensha:)
                                                    userInfo:dictionary
                                                     repeats:YES];
}

- (void)timerToMoveSensha:(NSTimer*)timer {
    UIImageView *imageViewOfSensha = [[timer userInfo] objectForKey:@"imageOfSensha"];
    CGPoint destination = [[[timer userInfo] objectForKey:@"destination"] CGPointValue];
    int locationX = (int)(imageViewOfSensha.center.x);
    int locationY = (int)(imageViewOfSensha.center.y);
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
    
    imageViewOfSensha.center = CGPointMake(locationX, locationY);
    
    if (destination.x <= locationX && destination.y <= locationY) {
        [imageViewOfSensha removeFromSuperview];
        [timer invalidate];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    selfSenshaImageView.center = CGPointMake(touchLocation.x, selfSenshaImageView.center.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    selfSenshaImageView.center = CGPointMake(touchLocation.x, selfSenshaImageView.center.y);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
