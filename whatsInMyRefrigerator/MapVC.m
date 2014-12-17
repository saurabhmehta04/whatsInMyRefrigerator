//
//  MapVC.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/14/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "MapVC.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapVC ()

@end

@implementation MapVC

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//    // Custom initialization
//    }
//return self;
//
//}

//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    self.locationManager = [[CLLocationManager alloc]init];
//    self.locationManager.delegate = self;
//    
//    [self.indicatorView startAnimating];
//    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
//        //[self.locationManager requestWhenInUseAuthorization];
//        
//    }
//    
////    for (Park *park in self.parks) {
////        [self.mapView addAnnotation:(id) park];
////    }
//    
//    // Map and Location initialization
//    self.locationManager = [[CLLocationManager alloc] init];
//    self.locationManager.delegate = self;
//    
//    self.mapView.delegate = self;
//    
//    [self.mapView setShowsUserLocation:YES];
//}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"In viewDidLoad");
    // create a GMSCameraPosition to display coordinates
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86 longitude:151.20 zoom:6];
    
    self.mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.view = self.mapView;
    
    // create a marker in the center of the map
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet=@"Austrailia";
    marker.map = self.mapView;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(void) zoomOnAnnotation:(id<MKAnnotation>) annotation{
////    [self.tabBarController setSelectedViewController:self];
////    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([annotation coordinate], 20000, 20000);
////    [self.mapView setRegion:region animated:YES];
////    [self.mapView selectAnnotation:annotation animated:YES];
//}

//- (void)startUpdating           //start location manager updating plus…
//{
//    [self.indicatorView startAnimating];
//    [self.locationManager startUpdatingLocation];
//}
//- (void)stopUpdating          //stop location manager updating plus…
//{
//    [self.indicatorView stopAnimating];
//    [self.locationManager stopUpdatingLocation];
//    
//}
//
//- (IBAction)refresh        //call startUpdating
//{
//    [self startUpdating];
//}
//
//- (IBAction)zoomIn
//{
//    MKCoordinateRegion region;
//    //Set Zoom level using Span
//    MKCoordinateSpan span;
//    region.center=self.mapView.region.center;
//    span.latitudeDelta=self.mapView.region.span.latitudeDelta /5;
//    span.longitudeDelta=self.mapView.region.span.longitudeDelta /5;
//    if (span.latitudeDelta<0.1){
//        span.latitudeDelta=0.1;
//        
//    }
//    if(span.longitudeDelta<0.1) {
//        span.longitudeDelta=0.1;
//    }
//    region.span=span;
//    NSLog(@"span.latitudeDelta: %f,longitudeDelta:%f",span.latitudeDelta,span.longitudeDelta);
//    [self.mapView setRegion:region animated:TRUE];
//}
//
//- (IBAction)zoomOut
//{
//    MKCoordinateRegion region;
//    //Set Zoom level using Span
//    MKCoordinateSpan span;
//    region.center=self.mapView.region.center;
//    span.latitudeDelta=self.mapView.region.span.latitudeDelta *5;
//    span.longitudeDelta=self.mapView.region.span.longitudeDelta *5;
//    if (span.latitudeDelta >90){
//        span.latitudeDelta=89.99;
//        
//    }
//    if(span.longitudeDelta>180) {
//        span.longitudeDelta=179.99;
//    }
//    region.span=span;
//    //NSLog(@"span.latitudeDelta: %f,longitudeDelta:%f",span.latitudeDelta,span.longitudeDelta);
//    [self.mapView setRegion:region animated:TRUE];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
//    
//    //[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stopUpdating) userInfo:nil repeats:NO];
//    
//    //CLLocationCoordinate2D *coordinate =
//    CLLocation *location = [locations lastObject];
//    CLLocationCoordinate2D coordinate = location.coordinate;
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 20000, 20000);
//    [self.mapView setRegion:region];
//    [self stopUpdating];
//}
//
//- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
//    NSLog(@"locationManager failed with error=%@",error);
//    [self stopUpdating];
//    [self.indicatorView stopAnimating];
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Location Manager Failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//    
//    [alert show];
//    
//}

//*/
//-(IBAction)mapType:(id)sender{
//    switch (((UISegmentedControl *)sender).selectedSegmentIndex)
//    {
//        case 0:
//        {
//            self.mapView.mapType = MKMapTypeStandard;
//            break;
//        }
//        case 1:
//        {
//            self.mapView.mapType = MKMapTypeSatellite;
//            break;
//        }
//        default:
//        {
//            self.mapView.mapType = MKMapTypeHybrid;
//            break;
//        }
//    }

//}



@end
