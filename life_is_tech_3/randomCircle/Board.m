//
//  Board.m
//  randomCircle
//
//  Created by Shotaro Watanabe on 5/23/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import "Board.h"

@implementation Board

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        circle = [[Circle alloc] init];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    for (int i = 0; i < 1000; i++) {
        int radius = [circle getRandomNum];
        CGContextSetFillColor(context, CGColorGetComponents([circle getColor].CGColor));
        CGContextFillEllipseInRect(context, CGRectMake([circle getRandomNum] * 2, [circle getRandomNum] * 4, radius, radius));
    }
}


@end
