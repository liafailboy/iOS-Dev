//
//  ViewController.m
//  tennis
//
//  Created by Shotaro Watanabe on 5/22/14.
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
    
    // 初めにボールが動く向きを乱数で計算
    randomNum = arc4random() % 20;
    moveX = 0.1 * randomNum;
    if (randomNum % 2 == 0) moveX = -moveX;
    randomNum = arc4random() % 20;
    moveY = 0.1 * randomNum;
    if (randomNum % 2 == 0) moveY = -moveY;
    
    /*
     発展型
     randomNum = arc4random() % 365
     moveX = cos(randomNum) * 2;
     moveY = sin(randomNum) * 2;
     */
    
    // ボールを動かすためのtimerをセット
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                             target:self
                                           selector:@selector(ballMove:)
                                           userInfo:nil
                                            repeats:YES];
    [timer fire];
}

// タイマーによって呼び出さzれるメソッド
- (void)ballMove:(NSTimer *)_timer {
    
    // 画面の大きさを取得
    CGRect main = [[UIScreen mainScreen] applicationFrame];
    
    // 初めの動きを開始
    ball.center = CGPointMake(ball.center.x + moveX, ball.center.y + moveY);
    
    // ballと横壁の当たり判定
    if(ball.center.x - ball.bounds.size.width / 2 < 0) moveX = - moveX;
    if(ball.center.x + ball.bounds.size.width / 2 > main.size.width) moveX = - moveX;
    
    // ballとラケットの当たり判定
    if(ball.center.y - ball.bounds.size.height / 2 < redBar.center.y + redBar.bounds.size.height / 2 &&
       ball.center.x > redBar.center.x - redBar.bounds.size.width / 2 &&
       ball.center.x < redBar.center.x + redBar.bounds.size.width / 2) moveY = - moveY;
    if(ball.center.y + ball.bounds.size.height / 2 > blueBar.center.y - blueBar.bounds.size.height / 2 &&
       ball.center.x > blueBar.center.x - blueBar.bounds.size.width / 2 &&
       ball.center.x < blueBar.center.x + blueBar.bounds.size.width / 2) moveY = - moveY;
    
    // ballがどちらかのコートに入ったことの当たり判定
    if (ball.center.y < 0 || main.size.height < ball.center.y) {
        NSString *winner = @"";
        if (ball.center.y < 0 ) {
            winner = @"青";
        } else {
            winner = @"赤";
        }
        
        // UIAlertViewを使用して勝敗を表示
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                        message:[NSString stringWithFormat:@"%@の勝ち！", winner]
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        
        // timerをストップ
        [timer invalidate];
    }
    
}

// 画面がtouchされたときに呼び出されるメソッド
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // 画面の大きさを取得
    CGRect main = [[UIScreen mainScreen] applicationFrame];
    
    // touchしている座標を取得
    CGPoint p = [[touches anyObject] locationInView:self.view];
    
    // 上部がタッチされたとき
    if (p.y < main.size.height / 2) {
        imageToMove = redBar;
    } else {
        imageToMove = blueBar;
    }
}

// 画面上でドラッグされたときに呼び出されるメソッド
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // touchしている座標を取得
    CGPoint p = [[touches anyObject] locationInView:self.view];
    
    // 画像の中心値を変更
    imageToMove.center = CGPointMake(p.x, imageToMove.center.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
