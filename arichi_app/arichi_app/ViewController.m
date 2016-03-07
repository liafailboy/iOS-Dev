//
//  ViewController.m
//  arichi_app
//
//  Created by Shotaro Watanabe on 2/6/16.
//  Copyright © 2016 liafailboy. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    count = 0;
    
    // initialize uiimageview
    imageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    imageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2.jpg"]];
    imageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3.jpg"]];
    imageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4.jpg"]];
    
    imageView1.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    imageView1.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    imageView2.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    imageView2.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    imageView3.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    imageView3.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    imageView4.bounds = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    imageView4.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2);
    
    // add imageviews to self.view
    [self.view addSubview:imageView4];
    [self.view addSubview:imageView3];
    [self.view addSubview:imageView2];
    [self.view addSubview:imageView1];
    
    // intitialize URL
    mySafari = [UIApplication sharedApplication];
    myURL = [[NSURL alloc]initWithString:@"http://www.foxnews.com/us/2016/01/03/atlanta-girl-shot-during-robbery-for-her-hoverboard.html"];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"screenTouched");
    
    // delete each image from the view and open website after
    switch (count) {
        case 0:
            [imageView1 removeFromSuperview];
            break;
        case 1:
            [imageView2 removeFromSuperview];
            break;
        case 2:
            [imageView3 removeFromSuperview];
            break;
        case 3:
            [imageView4 removeFromSuperview];
            break;
        default:
            [mySafari openURL:myURL];
            break;
    }
    
    count++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
