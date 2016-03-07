//
//  ViewController.m
//  CarLoc
//
//  Created by Shotaro Watanabe on 1/8/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize mapView, locationManager;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialize and add mapview to the self.view
    mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
    
    // initialize location manager to track GPS
    locmanager = [[CLLocationManager alloc] init];
    [locmanager setDelegate:self];
    [locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locmanager setDistanceFilter:kCLDistanceFilterNone];
    [locmanager startUpdatingLocation];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    // called every moment to update GPS
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    MKCoordinateRegion region = MKCoordinateRegionMake(newLocation.coordinate, span);
    [mapView setRegion:region animated:YES];
}

// Fail locating or User selected not allow to use GPS
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
