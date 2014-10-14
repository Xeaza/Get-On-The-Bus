//
//  ViewController.m
//  Get On The Bus
//
//  Created by Taylor Wright-Sanson on 10/14/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "Bus.h"

@interface ViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSURL *urlString = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    [self getJsonData:urlString];
}

- (void)getJsonData: (NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         NSError *jsonError;
         if (connectionError != nil)
         {
             NSLog(@"Connection error: %@", connectionError.localizedDescription);
         }
         if (jsonError != nil) {
             NSLog(@"JSON error: %@", jsonError.localizedDescription);
         }

         if (data)
         {
             NSDictionary *busDataJSON = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];

             NSArray *arrayOfBusJsonDicts =  [busDataJSON objectForKey:@"row"];
             // Create a bus object for each dictionary in the json array of dicts.
             for (NSDictionary *busJsonDict in arrayOfBusJsonDicts)
             {
                 Bus *bus = [[Bus alloc] initWithJSONDict:busJsonDict];
                 [self addBusStopPin:bus];
             }
         }
         else
         {
             NSLog(@"Bus data fail");
         }
     }];
}

- (void)addBusStopPin:(Bus *)bus
{
    MKPointAnnotation *busStopAnnotation = [[MKPointAnnotation alloc] init];
    busStopAnnotation.coordinate = bus.coord;
    busStopAnnotation.title = bus.ctaStop;
    [self.mapView addAnnotation:busStopAnnotation];
}

//-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    if (annotation == mapView.userLocation)
//    {
//        return nil;
//    }
//
//    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPinID"];
//    pin.canShowCallout = YES;
//    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//    pin.image = [UIImage imageNamed:@"calvin_boring"];
//
//    return pin;
//}

//-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
//{
//    CLLocationCoordinate2D center = view.annotation.coordinate;
//
//    MKCoordinateSpan span;
//    span.latitudeDelta = 0.01;
//    span.longitudeDelta = 0.01;
//
//    MKCoordinateRegion region;
//    region.center = center;
//    region.span = span;
//
//    [self.mapView setRegion:region animated:YES];
//}

@end
