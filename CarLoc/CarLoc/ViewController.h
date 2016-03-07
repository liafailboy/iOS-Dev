//
//  ViewController.h
//  CarLoc
//
//  Created by Shotaro Watanabe on 1/8/14.
//  Copyright (c) 2014 Shotaro Watanabe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate> {
	MKMapView* mapView;
	CLLocationManager* locmanager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) MKMapView *mapView;

@end
