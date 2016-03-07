//
//  carStartedViewController.m
//  carPlay
//
//  Created by Shotaro Watanabe on 2014/06/20.
//  Copyright (c) 2014年 liafailboy. All rights reserved.
//

#import "carStartedViewController.h"

@interface carStartedViewController ()
@property (strong,nonatomic) AVAudioPlayer *avpToPlay;
@property (strong,nonatomic) AVAudioPlayer *avpC01;
@property (strong,nonatomic) AVAudioPlayer *avpC02;
@property (strong,nonatomic) AVAudioPlayer *avpC03;
@property (strong,nonatomic) AVAudioPlayer *avpC04;
@property (strong,nonatomic) AVAudioPlayer *avpC05;
@property (strong,nonatomic) AVAudioPlayer *avpE01;
@property (strong,nonatomic) AVAudioPlayer *avpE02;
@property (strong,nonatomic) AVAudioPlayer *avpE03;
@property (strong,nonatomic) AVAudioPlayer *avpE04;
@property (strong,nonatomic) AVAudioPlayer *avpE05;
@end

@implementation carStartedViewController

@synthesize locMgr;

NSUserDefaults *defaults;

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
    // Do any additional setup after loading the view from its nib.
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    totalDistance = [defaults doubleForKey:@"totalDistance"];
    totalCoins = (int)[defaults integerForKey:@"totalCoins"];
    
    isNotMinus = YES;
    
    doTutorial = NO;
    
    back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    back.frame = CGRectMake(126, 215, 10366, 378);
    [self.view addSubview:back];
    
    carImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"car.png"]];
    carImage.frame = CGRectMake(0, 489, 120, 76);
    [self.view addSubview:carImage];
    
    tunnel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_tunnel.png"]];
    tunnel.frame = CGRectMake(0, 511, 128, 92);
    [self.view addSubview:tunnel];
    
    [self.view addSubview:coin];
    [self.view addSubview:distance];
    [self.view addSubview:songs];
    
    timerForCarMove = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                      target:self
                                                    selector:@selector(carStartMove)
                                                    userInfo:nil
                                                     repeats:YES];
    
    locMgr = [[CLLocationManager alloc] init];
    if ([CLLocationManager locationServicesEnabled]) {
        locMgr.delegate = self;
        locMgr.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [locMgr startUpdatingLocation];
    } else {
        NSLog(@"GPS is not available on this device");
    }
    
    speedOfCar = 10;
    
    isCalm = YES;
    
    NSURL *url01 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"calm_01" ofType:@"caf"]];
    self.avpC01 = [[AVAudioPlayer alloc] initWithContentsOfURL:url01 error:nil];
    NSURL *url02 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"calm_02" ofType:@"caf"]];
    self.avpC02 = [[AVAudioPlayer alloc] initWithContentsOfURL:url02 error:nil];
    NSURL *url03 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"calm_03" ofType:@"caf"]];
    self.avpC03 = [[AVAudioPlayer alloc] initWithContentsOfURL:url03 error:nil];
    NSURL *url04 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"calm_04" ofType:@"caf"]];
    self.avpC04 = [[AVAudioPlayer alloc] initWithContentsOfURL:url04 error:nil];
    NSURL *url05 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"calm_05" ofType:@"caf"]];
    self.avpC05 = [[AVAudioPlayer alloc] initWithContentsOfURL:url05 error:nil];
    NSURL *url06 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"exciting_01" ofType:@"caf"]];
    self.avpE01 = [[AVAudioPlayer alloc] initWithContentsOfURL:url06 error:nil];
    NSURL *url07 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"exciting_02" ofType:@"caf"]];
    self.avpE02 = [[AVAudioPlayer alloc] initWithContentsOfURL:url07 error:nil];
    NSURL *url08 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"exciting_03" ofType:@"caf"]];
    self.avpE03 = [[AVAudioPlayer alloc] initWithContentsOfURL:url08 error:nil];
    NSURL *url09 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"exciting_04" ofType:@"caf"]];
    self.avpE04 = [[AVAudioPlayer alloc] initWithContentsOfURL:url09 error:nil];
    NSURL *url10 = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"exciting_05" ofType:@"caf"]];
    self.avpE05 = [[AVAudioPlayer alloc] initWithContentsOfURL:url10 error:nil];
    
    arrayOfArtists = [NSArray arrayWithObjects:@"グランパ", @"稿屋 隆", @"海の見える町", @"hayamoni", @"piano#02", @"Takumi Higashi", @"Rain Drift", @"Anonyment", @"so sweet", @"稿屋 隆", @"Quick pipes", @"稿屋 隆", @"タイムベンド", @"かずち", @"ゲームチュートリアル", @"稿屋 隆", @"BRUTE FORCE ATTACK", @"稿屋 隆", @"Rage in 16bit", @"kenapo", nil];
    
    if (totalCoins <= 0) {
        tutorial = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tutorial.jpg"]];
        tutorial.frame = CGRectMake(0, 0, 320, 568);
        [self.view addSubview:tutorial];
        doTutorial = YES;
    }
    
    [self startPlay];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
    UISwipeGestureRecognizer *swipeToUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeUp:)];
    swipeToUp.direction = UISwipeGestureRecognizerDirectionUp;
    [self.view addGestureRecognizer:swipeToUp];
    
    UISwipeGestureRecognizer *swipeToDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeDown:)];
    swipeToDown.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:swipeToDown];
    
    UISwipeGestureRecognizer *swipeToRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeRight:)];
    swipeToRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeToRight];
    
    UISwipeGestureRecognizer *swipeToLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeToLeft:)];
    swipeToLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeToLeft];

}

- (void)handleTapGesture:(UITapGestureRecognizer *)sender {
    [tutorial removeFromSuperview];
    if (!doTutorial) {
        if (isPlaying) {
            [self doAnimation:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"stop.png"]]];
            [self.avpToPlay stop];
            isPlaying = NO;
            speedOfCar = 0;
        } else {
            [self doAnimation:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"play.png"]]];
            self.avpToPlay.numberOfLoops = -1;
            [self.avpToPlay play];
            isPlaying = YES;
        }
    }
    doTutorial = NO;
}



- (void)handleSwipeUp:(UISwipeGestureRecognizer *)sender {
    [self doAnimation:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star.png"]]];
}

- (void)handleSwipeDown:(UISwipeGestureRecognizer *)sender {
    [self doAnimation:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"trash.png"]]];
}

- (void)handleSwipeRight:(UISwipeGestureRecognizer *)sender {
    [self doAnimation:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"back.png"]]];
    [self.avpToPlay stop];
    self.avpToPlay.currentTime = 0;
    [self.avpToPlay play];
}

- (void)handleSwipeToLeft:(UISwipeGestureRecognizer *)sender {
    [self doAnimation:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"next.png"]]];
    [self.avpToPlay stop];
    [self startPlay];
}

- (void)doAnimation:(UIImageView *)imageView {
    stateImage = [[UIImageView alloc] init];
    stateImage = imageView;
    stateImage.frame = CGRectMake(0, 0, stateImage.bounds.size.width / 14 , stateImage.bounds.size.height / 14);
    stateImage.center = self.view.center;
    stateImage.alpha = 1;
    stateImage.userInteractionEnabled = YES;
    [self.view addSubview:stateImage];
    timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                      target:self
                                                    selector:@selector(decreaseAlpha)
                                                    userInfo:nil
                                                     repeats:YES];
}

- (void)decreaseAlpha {
    stateImage.frame = CGRectMake(0, 0, stateImage.bounds.size.width + 2 , stateImage.bounds.size.height + 2);
    stateImage.center = self.view.center;
    if (stateImage.alpha <= 0) {
        [timer invalidate];
    } else {
        stateImage.alpha =  stateImage.alpha - 0.2;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    
    BOOL wasWhat = isCalm;
    
    CLLocationDistance dis = [newLocation distanceFromLocation:oldLocation];
    totalDistance = totalDistance + dis;
    distance.text = [NSString stringWithFormat:@"%.1f km", totalDistance / 1000];
    coin.text = [NSString stringWithFormat:@"%d coins", totalCoins];
    [defaults setDouble:totalDistance forKey:@"totalDistance"];
    [defaults setInteger:totalCoins forKey:@"totalCoins"];
    
    NSLog(@"%f", [newLocation speed] * 3.3);
    
    if ([newLocation speed] >= 13.4) {
        isCalm = NO;
        if (isPlaying) speedOfCar = 20;
    } else {
        isCalm = YES;
        if (isPlaying) speedOfCar = 10;
    }

    if (wasWhat != isCalm) {
        [self.avpToPlay stop];
        [self startPlay];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Failed with error.");
}


- (void)startPlay {
    int num = arc4random() % 5;
    if (isCalm) {
        switch (num) {
            case 0:
                self.avpToPlay = self.avpC01;
                break;
            case 1:
                self.avpToPlay = self.avpC02;
                break;
            case 2:
                self.avpToPlay = self.avpC03;
                break;
            case 3:
                self.avpToPlay = self.avpC04;
                break;
            case 4:
                self.avpToPlay = self.avpC05;
                break;
            default:
                break;
        }
    } else {
        switch (num) {
            case 0:
                self.avpToPlay = self.avpE01;
                break;
            case 1:
                self.avpToPlay = self.avpE02;
                break;
            case 2:
                self.avpToPlay = self.avpE03;
                break;
            case 3:
                self.avpToPlay = self.avpE04;
                break;
            case 4:
                self.avpToPlay = self.avpE05;
                break;
            default:
                break;
        }
    }
    self.avpToPlay.delegate = self;
    self.avpToPlay.numberOfLoops = -1;
    [self.avpToPlay play];
    if (!isCalm) num = num + 5;
    label1.text = [NSString stringWithFormat:@"♪ %@",[arrayOfArtists objectAtIndex:num * 2]];
    label2.text = [arrayOfArtists objectAtIndex:num * 2 + 1];
    isPlaying = YES;
    totalCoins = totalCoins + arc4random() % 10;
}

- (void)carStartMove {
    
    if (carImage.center.x <= 160) carImage.center = CGPointMake(carImage.center.x + speedOfCar, carImage.center.y);
    tunnel.center = CGPointMake(tunnel.center.x - speedOfCar, tunnel.center.y);
    back.center = CGPointMake(back.center.x - speedOfCar, back.center.y);
    
    if (isNotMinus) {
        carImage.center = CGPointMake(carImage.center.x, carImage.center.y + 3);
        isNotMinus = NO;
    } else {
        carImage.center = CGPointMake(carImage.center.x, carImage.center.y - 3);
        isNotMinus = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    NSLog(@"nooooooooo");
    // Dispose of any resources that can be recreated.
}

@end
