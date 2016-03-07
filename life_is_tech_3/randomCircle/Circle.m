//
//  Circle.m
//  randomCircle
//
//  Created by Shotaro Watanabe on 5/23/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import "Circle.h"

@implementation Circle

// このクラスのインスタンスが生成されるときに呼び出されるメソッド
- (id)init {
    
    // 初期化しているクラスが正しいものかの確認
    if (self == [super init]) {
    }
    return self;
}

// ランダムな数字を返す
- (int)getRandomNum {
    
    // 円の大きさ、位置、色をランダムにするためにランダムな数字を生成
    randomNum = arc4random() % 100 + 1;
    
    return randomNum;
}

// ランダムな色を返す
- (UIColor *)getColor {
    // 円の大きさ、位置、色をランダムにするためにランダムな数字を生成
    randomNum = arc4random() % 100 + 1;
    
    // ランダムな数字をもとに赤、青、緑、黄色の色をrandomColorに入れる
    if (randomNum % 2 == 0) {
        randomColor = [UIColor redColor];
    } else if (randomNum % 3 == 0) {
        randomColor = [UIColor blueColor];
    } else if (randomNum % 5 == 0) {
        randomColor = [UIColor greenColor];
    } else if (randomNum % 7 == 0) {
        randomColor = [UIColor yellowColor];
    }
    
    return randomColor;
}

@end
