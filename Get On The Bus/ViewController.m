//
//  ViewController.m
//  Get On The Bus
//
//  Created by Taylor Wright-Sanson on 10/14/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import "BusStopAnnotation.h"

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
                 BusStopAnnotation *busStop = [[BusStopAnnotation alloc] initWithJSONDict:busJsonDict];
                 [self.mapView addAnnotation:busStop];
             }
         }
         else
         {
             NSLog(@"Bus data fail");
         }
     }];
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation)
    {
        return nil;
    }

    MKPinAnnotationView *pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPinID"];
    pin.canShowCallout = YES;
    pin.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    //CGSize            size = CGSizeMake(100.0, 80.0);
    //pin.annotation. //.view.frame = CGRectMake(0.0, 0.0, size.width, size.height);
   // [pin.inputView setBounds:CGRectMake(0, 0, 200, 300)];
    //pin.image = [UIImage imageNamed:@"calvin_boring"];


//    if ([annotation isKindOfClass:[CustomAnnotation class]]) {
//        MKPinAnnotationView *view = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customIdentifier];
//        view.canShowCallout       = NO;  // make sure to turn off standard callout
//        return view;
    //}
    //if ([annotation isKindOfClass:[CalloutAnnotation class]]) {
        //CGSize            size = CGSizeMake(100.0, 80.0);
        //MKAnnotationView *view = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MyPinID"];
        //view.frame             = CGRectMake(0.0, 0.0, size.width, size.height);
        //view.backgroundColor   = [UIColor whiteColor];
        //UIButton *button       = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //button.frame           = CGRectMake(5.0, 5.0, size.width - 10.0, size.height - 10.0);
        //[button setTitle:@"OK" forState:UIControlStateNormal];
        //[button addTarget:self action:@selector(didTouchUpInsideCalloutButton:) forControlEvents:UIControlEventTouchUpInside];
        //[view addSubview:button];
        //view.canShowCallout    = NO;
        //view.centerOffset      = CGPointMake(0.0, -kMyCalloutOffset);
        //return view;
   // }

   // return nil;
//}
    return pin;
}

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
