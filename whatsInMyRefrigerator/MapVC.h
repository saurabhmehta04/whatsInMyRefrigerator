//
//  MapVC.h
//  whatsInMyRefrigerator
//
//  Created by Student on 12/14/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import "ZoomingProtocol.h"
#import <GoogleMaps/GoogleMaps.h>



@interface MapVC : UIViewController<GMSMapViewDelegate>
//<MKMapViewDelegate,CLLocationManagerDelegate,ZoomingProtocol>
//
//
//@property (strong, nonatomic) IBOutlet MKMapView *mapView;
//@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
//@property (strong, nonatomic) CLLocationManager *locationManager;
//@property (strong, nonatomic) NSMutableArray *parks;
//
//- (void)startUpdating; //start location manager updating plus…
//- (void)stopUpdating;  //stop location manager updating plus…
//- (IBAction)refresh;   //call startUpdating
//- (IBAction)zoomOut;   //call startUpdating
//- (IBAction)zoomIn;
//- (IBAction)mapType:(id)sender;
//
//-(void) zoomOnAnnotation:(id<MKAnnotation>) annotation;
@property (strong, nonatomic) IBOutlet GMSMapView *mapView;

@end
