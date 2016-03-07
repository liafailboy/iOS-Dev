//
//  myPaceViewController.m
//  DOCTOR PLUS
//
//  Created by Shotaro Watanabe on 5/27/14.
//  Copyright (c) 2014 J-Workout. All rights reserved.
//

#import "myPaceViewController.h"

@interface myPaceViewController ()

@end

@implementation myPaceViewController

@synthesize imageFiles = imageFiles_;

@synthesize scrollView = scrollView_;

@synthesize previousScrollView = previousScrollView_;
@synthesize currentScrollView = currentScrollView_;
@synthesize nextScrollView = nextScrollView_;

@synthesize currentIndex = currentIndex_;

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
    // Do any additional setup after loading the view.
    
    switch (whichAlp) {
        case 0:
            count = 25;
            string = @"A";
            break;
        case 1:
            count = 20;
            string = @"B";
            break;
        case 2:
            count = 25;
            string = @"C";
            break;
        case 3:
            count = 25;
            string = @"D";
            break;
        case 4:
            count = 5;
            string = @"E";
            break;
        default:
            count = 0;
            string = @"";
            break;
    }
    
    NSString* path = [[NSBundle mainBundle] resourcePath];
	imageFiles = [[NSMutableArray alloc] init];
	for (int i=0; i < count; i++) {
		[imageFiles addObject:[NSString stringWithFormat:@"%@/d+100_%@-%02d.png", path, string, i+1]];
		NSLog(@"%@", [imageFiles objectAtIndex:i]);
	}
    
    // setup scroll views
    CGRect imageScrollViewFrame = CGRectZero;
    imageScrollViewFrame.size = self.scrollView.frame.size;
    imageScrollViewFrame.origin.x = (self.currentIndex-1) * imageScrollViewFrame.size.width;
    
    CGRect imageViewFrame = CGRectZero;
    imageViewFrame.size = self.scrollView.frame.size;
    
    for (int i = 0; i < 3; i++) {
        
        // image view
        imageView =
        [[UIImageView alloc] initWithFrame:imageViewFrame];
        imageView.userInteractionEnabled = YES;
        
        // scroll view
        imageScrollView =
        [[UIScrollView alloc] initWithFrame:imageScrollViewFrame];
        imageScrollView.minimumZoomScale = 1.0;
        imageScrollView.maximumZoomScale = 5.0;
        imageScrollView.showsHorizontalScrollIndicator = NO;
        imageScrollView.showsVerticalScrollIndicator = NO;
        imageScrollView.backgroundColor = [UIColor blackColor];
        
        // bind views
        [imageScrollView addSubview:imageView];
        [self.scrollView addSubview:imageScrollView];
        
        // assign to iVars
        switch (i) {
            case 0:
                self.previousScrollView = imageScrollView;
                break;
            case 1:
                self.currentScrollView = imageScrollView;
                break;
            case 2:
                self.nextScrollView = imageScrollView;
                break;
        }
        
        // next image
        imageScrollViewFrame.origin.x += imageScrollViewFrame.size.width;
    }
    
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.scrollsToTop = NO;
    
    [self adjustViews];
    [self scrollToIndex:self.currentIndex animated:NO]; 
}


- (void)adjustViews
{
    CGSize contentSize = CGSizeMake(
                                    self.currentScrollView.frame.size.width * [imageFiles count],
                                    self.currentScrollView.frame.size.height);
    self.scrollView.contentSize = contentSize;
    
    [self setImageAtIndex:self.currentIndex - 1 toScrollView:self.previousScrollView];
    [self setImageAtIndex:self.currentIndex   toScrollView:self.currentScrollView];
    [self setImageAtIndex:self.currentIndex + 1 toScrollView:self.nextScrollView];
}

- (void)setImageAtIndex:(NSInteger)index toScrollView:(UIScrollView*)scrollView
{
    imageView = [scrollView.subviews objectAtIndex:0];
    imageView.userInteractionEnabled = YES;
    if (index < 0 || [imageFiles count] <= index) {
        imageView.image = nil;
        scrollView.delegate = nil;
        return;
    }
    
    UIImage* image = [UIImage imageWithContentsOfFile:[imageFiles objectAtIndex:index]];
    imageView.image = image;
    imageView.contentMode = (image.size.width > image.size.height) ?
    UIViewContentModeScaleAspectFit : UIViewContentModeScaleAspectFill;
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated
{
	CGPoint contentOffset =
	CGPointMake(index * self.scrollView.frame.size.width, 0);
	[self.scrollView setContentOffset:contentOffset animated:animated];
	
}

#pragma mark -
#pragma mark UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat position = scrollView.contentOffset.x / scrollView.bounds.size.width;
    CGFloat delta = position - (CGFloat)self.currentIndex;
    
    if (fabs(delta) >= 1.0f) {
        self.currentScrollView.zoomScale = 1.0;
        self.currentScrollView.contentOffset = CGPointZero;
        
        if (delta > 0) {
            // the current page moved to right
            self.currentIndex = self.currentIndex + 1; // no check (no over case)
            [self setupNextImage];
            
        } else {
            // the current page moved to left
            self.currentIndex = self.currentIndex - 1; // no check (no over case)
            [self setupPreviousImage];
        }
        
    }
    
}

-(void)setupPreviousImage
{
    UIScrollView* tmpView = self.currentScrollView;
    
    self.currentScrollView = self.previousScrollView;
    self.previousScrollView = self.nextScrollView;
    self.nextScrollView = tmpView;
    
    CGRect frame = self.currentScrollView.frame;
    frame.origin.x -= frame.size.width;
    self.previousScrollView.frame = frame;
    [self setImageAtIndex:self.currentIndex-1 toScrollView:self.previousScrollView];
}

-(void)setupNextImage
{
    UIScrollView* tmpView = self.currentScrollView;
    
    self.currentScrollView = self.nextScrollView;
    self.nextScrollView = self.previousScrollView;
    self.previousScrollView = tmpView;
    
    CGRect frame = self.currentScrollView.frame;
    frame.origin.x += frame.size.width;
    self.nextScrollView.frame = frame;
    [self setImageAtIndex:self.currentIndex+1 toScrollView:self.nextScrollView];
}

-(IBAction)backToMenu:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    NSString* path = [[NSBundle mainBundle] resourcePath];
//    imageFiles = [[NSMutableArray alloc] init];
//    for (int i=0; i < count; i++) {
//        [imageFiles addObject:[NSString stringWithFormat:@"%@/d+100_A-%02dura.png", path, i+1]];
//        NSLog(@"%@", [imageFiles objectAtIndex:i]);
//    }
//    [imageView removeFromSuperview];
//    [imageScrollView removeFromSuperview];
//    [imageScrollView addSubview:imageView];
//    [self.scrollView addSubview:imageScrollView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
