//
//  myPaceViewController.h
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 5/27/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "myPaceChooseViewController.h"

@interface myPaceViewController : UIViewController <UIScrollViewDelegate>{
    // array to hold data of image files
    NSMutableArray *imageFiles;
    
    // set the background scrollview for the cards
    UIScrollView *scrollView_;
    
    // set the top scrollview for the cards
	UIScrollView *previousScrollView_;
	UIScrollView *currentScrollView_;
	UIScrollView *nextScrollView_;
    UIScrollView* imageScrollView;
	
    // set the image view on top of the scrollviews
    UIImageView *imageView;
    
    // hold the value where is the user currently be
	NSInteger currentIndex_;
    
    int count;
    NSString *string;
}

@property (nonatomic, retain) IBOutlet 	NSMutableArray *imageFiles;

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) UIScrollView *previousScrollView;
@property (nonatomic, retain) UIScrollView *currentScrollView;
@property (nonatomic, retain) UIScrollView *nextScrollView;

@property (nonatomic, assign) NSInteger currentIndex;

-(IBAction)backToMenu:(id)sender;
-(IBAction)touchEvent:(id)sender;

@end
