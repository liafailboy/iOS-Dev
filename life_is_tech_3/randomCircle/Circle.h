//
//  Circle.h
//  randomCircle
//
//  Created by Shotaro Watanabe on 5/23/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Circle : NSObject {
    int randomNum;
    UIColor *randomColor;
}

- (int)getRandomNum;
- (UIColor *)getColor;

@end
