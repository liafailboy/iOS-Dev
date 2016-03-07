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
@synthesize mapView = _mapView;

BOOL isFirstTime = YES;
CLLocationCoordinate2D coors[2];

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
    //mapviewを初期の大きさに設定
    map = [[MKMapView alloc] initWithFrame:self.view.bounds];
    
    //mapviewのdelegateをselfに設定
    map.delegate = self;
    
    //mapview上でGPSの位置情報を配置する
    map.showsUserLocation = YES;
    
    //mapviewを今のviewに追加する
    [self.view addSubview:map];
    
    //locManagerを初期化する
    locmanager = [[CLLocationManager alloc] init];
    
    //locManagerのdelegateをselfに設定
    [locmanager setDelegate:self];
    
    //現在地の正確さを最高に設定
    [locmanager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //1mごとに現在地を取得し直すように設定
    locmanager.distanceFilter = 1.00;
    
    //GPSの位置情報の更新を始める
    [locmanager startUpdatingLocation];
    
    //GPSの初期df値を設定
    coors[0] = CLLocationCoordinate2DMake(37.331800, -122.030581);
    coors[1] = CLLocationCoordinate2DMake(37.331800, -122.030581);
}

// iPhoneが新しいGPS情報を手に入れたときに呼ばれるメソッド
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *) oldLocation {
    
    //古い点と新しい点を配列に入れる
    if(!isFirstTime) coors[0] = CLLocationCoordinate2DMake(oldLocation.coordinate.latitude, oldLocation.coordinate.longitude);
    coors[1] = CLLocationCoordinate2DMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    isFirstTime = NO;
    
    //配列をMLPolyLineというオブジェクトに変更
    MKPolyline *line = [MKPolyline polylineWithCoordinates:coors count:2];
    
    //mapviewにlineを追加する
    [map addOverlay:line];
    
    //Mapkitの座標の縮尺度を設定する
    MKCoordinateSpan span = MKCoordinateSpanMake(0.005, 0.005);
    
    //Mapkitの縮尺度をMKCoordinateRegionに設定
    MKCoordinateRegion region = MKCoordinateRegionMake(newLocation.coordinate, span);
    
    //mapViewの縮尺度、位置を表示
    [map setRegion:region animated:YES];
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    //地図上に線を引くためのオブジェクトの初期化
    MKPolylineView *view = [[MKPolylineView alloc] initWithOverlay:overlay];
    
    //線の色を赤に設定
    view.strokeColor = [UIColor redColor];
    
    //線の太さを5ピクセルに設定
    view.lineWidth = 5.0;
    
    //設定情報を戻す
    return view;
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    static NSString* AnnotationIdentifier = @"Annotation";
    MKPinAnnotationView *pinView = (MKPinAnnotationView *)[map dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
    
    if (!pinView) {
        
        MKPinAnnotationView *customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        if (annotation == mapView.userLocation) customPinView.image = [UIImage imageNamed:@"runner.png"];
        else customPinView.image = [UIImage imageNamed:@"runner.png"];
        customPinView.animatesDrop = NO;
        customPinView.canShowCallout = YES;
        return customPinView;
        
    } else {
        
        pinView.annotation = annotation;
    }
    
    return pinView;
}

//GPS情報取得時エラー発生した場合に呼ばれる
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
