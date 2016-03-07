//
//  UIScrollView+TouchEvent.m
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 10/6/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import "UIScrollView+TouchEvent.h"

@implementation UIScrollView (UIScrollView_TouchEvent)

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

@end
