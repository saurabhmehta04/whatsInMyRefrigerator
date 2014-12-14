//
//  MapVC.m
//  whatsInMyRefrigerator
//
//  Created by Student on 12/14/14.
//  Copyright (c) 2014 -=fAlC0n=-. All rights reserved.
//

#import "MapVC.h"

@interface MapVC ()

@end

@implementation MapVC

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
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    
    [self.indicatorView startAnimating];
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        //[self.locationManager requestWhenInUseAuthorization];
        
    }
    
//    for (Park *park in self.parks) {
//        [self.mapView addAnnotation:(id) park];
//    }
    
    // Map and Location initialization
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.mapView.delegate = self;
    
    [self.mapView setShowsUserLocation:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void) zoomOnAnnotation:(id<MKAnnotation>) annotation{
    [self.tabBarController setSelectedViewController:self];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([annotation coordinate], 20000, 20000);
    [self.mapView setRegion:region animated:YES];
    [self.mapView selectAnnotation:annotation animated:YES];
}

- (void)startUpdating           //start location manager updating plus…
{
    [self.indicatorView startAnimating];
    [self.locationManager startUpdatingLocation];
}
- (void)stopUpdating          //stop location manager updating plus…
{
    [self.indicatorView stopAnimating];
    [self.locationManager stopUpdatingLocation];
    
}

- (IBAction)refresh        //call startUpdating
{
    [self startUpdating];
}

- (IBAction)zoomIn
{
    MKCoordinateRegion region;
    //Set Zoom level using Span
    MKCoordinateSpan span;
    region.center=self.mapView.region.center;
    span.latitudeDelta=self.mapView.region.span.latitudeDelta /5;
    span.longitudeDelta=self.mapView.region.span.longitudeDelta /5;
    if (span.latitudeDelta<0.1){
        span.latitudeDelta=0.1;
        
    }
    if(span.longitudeDelta<0.1) {
        span.longitudeDelta=0.1;
    }
    region.span=span;
    NSLog(@"span.latitudeDelta: %f,longitudeDelta:%f",span.latitudeDelta,span.longitudeDelta);
    [self.mapView setRegion:region animated:TRUE];
}

- (IBAction)zoomOut
{
    MKCoordinateRegion region;
    //Set Zoom level using Span
    MKCoordinateSpan span;
    region.center=self.mapView.region.center;
    span.latitudeDelta=self.mapView.region.span.latitudeDelta *5;
    span.longitudeDelta=self.mapView.region.span.longitudeDelta *5;
    if (span.latitudeDelta >90){
        span.latitudeDelta=89.99;
        
    }
    if(span.longitudeDelta>180) {
        span.longitudeDelta=179.99;
    }
    region.span=span;
    //NSLog(@"span.latitudeDelta: %f,longitudeDelta:%f",span.latitudeDelta,span.longitudeDelta);
    [self.mapView setRegion:region animated:TRUE];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    //[NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(stopUpdating) userInfo:nil repeats:NO];
    
    //CLLocationCoordinate2D *coordinate =
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 20000, 20000);
    [self.mapView setRegion:region];
    [self stopUpdating];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"locationManager failed with error=%@",error);
    [self stopUpdating];
    [self.indicatorView stopAnimating];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Location Manager Failed!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
    
}

/*


// This delegate method is called once for every annotation that is created.
// If no view is returned by this method, then only the default pin is seen by the user
- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation{
    MKAnnotationView *view = nil;
    //[self.indicatorView startAnimating];
    if(annotation != mv.userLocation) {
        // if it's NOT the user's current location pin, create the annotation
        Park *parkAnnotation = (Park*)annotation;
        // Look for an existing view to reuse
        view = [mv dequeueReusableAnnotationViewWithIdentifier:@"parkAnnotation"];
        // If an existing view is not found, create a new one
        if(view == nil) {
            view = [[MKPinAnnotationView alloc] initWithAnnotation:(id) parkAnnotation
                                                   reuseIdentifier:@"parkAnnotation"];
        }
        
        // Now we have a view for the annotation, so let's set some properties
        [(MKPinAnnotationView *)view setPinColor:MKPinAnnotationColorRed];
        [(MKPinAnnotationView *)view setAnimatesDrop:YES];
        [view setCanShowCallout:YES];
        
        // Now create buttons for the annotation view
        // The 'tag' properties are set so that we can identify which button was tapped later
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
        leftButton.tag = 0;
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        rightButton.tag = 1;
        
        // Add buttons to annotation view
        [view setLeftCalloutAccessoryView:leftButton];
        [view setRightCalloutAccessoryView:rightButton];
    }
    
    // send this annotation view back to MKmapView so it can add it to the pin
    [self.indicatorView stopAnimating];
    return view;
}

- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    Park *parkAnnotation = (Park *)[view annotation];
    switch ([control tag]) {
        case 0:
        {
            NSURL *url = [NSURL URLWithString:parkAnnotation.link];
            [[UIApplication sharedApplication] openURL:url];
        }
            break;
        case 1:
        {
            CLGeocoder *geocoder = [[CLGeocoder alloc]init];
            [geocoder reverseGeocodeLocation:parkAnnotation.location completionHandler:^(NSArray *placemarks, NSError *err) {
                if (err) {
                    NSLog(@"GeoCode Failed with error: %@",err);
                    return;
                }
                if(placemarks && placemarks.count > 0){
                    CLPlacemark *placemark = placemarks[0];
                    NSDictionary *addDict = placemark.addressDictionary;
                    MKPlacemark *place = [[MKPlacemark alloc]initWithCoordinate:parkAnnotation.location.coordinate addressDictionary:addDict];
                    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:place];
                    NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving};
                    [mapItem openInMapsWithLaunchOptions:options];
                }
            }];
        }
            break;
        default:
            NSLog(@"Should not be here in calloutAccessoryControlTapped, tag=%ld!",(long)[control tag]);
            break;
    }
}
*/
-(IBAction)mapType:(id)sender{
    switch (((UISegmentedControl *)sender).selectedSegmentIndex)
    {
        case 0:
        {
            self.mapView.mapType = MKMapTypeStandard;
            break;
        }
        case 1:
        {
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        }
        default:
        {
            self.mapView.mapType = MKMapTypeHybrid;
            break;
        }
    }
    
}



@end
