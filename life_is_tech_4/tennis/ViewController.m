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

@synthesize peerID = peerID_;
@synthesize session = session_;

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
    
    firstTime = YES;
}

// タイマーによって呼び出されるメソッド
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
    // touchしている座標を取得
    p = [[touches anyObject] locationInView:self.view];
    
    // 画像の中心値を変更
    blueBar.center = CGPointMake(p.x, blueBar.center.y);
}

// 画面上でドラッグされたときに呼び出されるメソッド
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    // touchしている座標を取得
    p = [[touches anyObject] locationInView:self.view];
    
    // 画像の中心値を変更
    blueBar.center = CGPointMake(p.x, blueBar.center.y);
}

- (IBAction)connect:(id)sender {
    
    // GKPeerPickerControllerを初期化
    GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
    
    // pickerのdelegateを自分自身に設定
    picker.delegate = self;
    
    // pickerの接続をインターネット経由でなく、近くのデバイスに設定
    picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
    
    // pickerを表示
    [picker show];
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session {
    
    // 相手のデバイスのIDをこちらの変数に入れる
    self.peerID = peerID;
    
    // 相手とのsessionの情報をこちらの変数に入れる
    self.session = session;
    
    // sessionのdelegateを自分自身に設定
    session.delegate = self;
    
    // sessionのデータ受け取り形式を設定
    [session setDataReceiveHandler:self withContext:nil];
    
    // pickerのdelegateをなしに設定
    picker.delegate = nil;
    
    // pickerを削除
    [picker dismiss];
    
    // ボタンを画面から削除
    connect.hidden = YES;
    
    // CGPointの情報をNSDataに変換
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSValue valueWithCGPoint:CGPointMake(moveX, moveY)]];
    
    // NSErrorを定義
    NSError* error = nil;
    
    // 相手に情報を送信
    [self.session sendData:data
                   toPeers:[NSArray arrayWithObject:self.peerID]
              withDataMode:GKSendDataReliable
                     error:&error];
    
    // 失敗時にエラーメッセージを表示
    if (error) NSLog(@"%@", error);
    
    // ボールを動かすためのtimerをセット
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                             target:self
                                           selector:@selector(ballMove:)
                                           userInfo:nil
                                            repeats:YES];
    [timer fire];
    
    // 赤いbarを動かすためのtimerをセット
    NSTimer *timerForRed = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                            target:self
                                                          selector:@selector(moveRed)
                                                          userInfo:nil
                                                           repeats:YES];
    [timerForRed fire];
}

- (void)moveRed {
    
    // CGPointの情報をNSDataに変換
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSValue valueWithCGPoint:p]];
    
    // NSErrorを定義
    NSError* error = nil;
    
    // 相手に情報を送信
    [self.session sendData:data
                   toPeers:[NSArray arrayWithObject:self.peerID]
              withDataMode:GKSendDataReliable
                     error:&error];
    
    // 失敗時にエラーメッセージを表示
    if (error) NSLog(@"%@", error);
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
    
    // NSDataをNSValueに変換
    NSValue *value = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    // NSValueをCGPointに変換
    CGPoint redP = [value CGPointValue];
    
    if (firstTime) {
        moveX = (moveX + redP.x) / 2;
        moveY = (moveY + redP.y) / 2;
        firstTime = NO;
    } else {
        // redBarを動かす
        redBar.center = CGPointMake(redP.x, redBar.center.y);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
