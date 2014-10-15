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
#import "BusStopDetailViewController.h"

@interface ViewController () <MKMapViewDelegate,  UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *busStopsArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.busStopsArray = [[NSMutableArray alloc] init];
    NSURL *urlString = [NSURL URLWithString:@"https://s3.amazonaws.com/mobile-makers-lib/bus.json"];
    [self getJsonData:urlString];
    self.tableView.alpha = 0.0;
}

- (IBAction)indexDidChangeForSegmentedControl:(UISegmentedControl*)segmentedControl
{
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.tableView.alpha = 0.0;
            }];
            break;
        }
        case 1:
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.tableView.alpha = 1.0;
            }];
            break;
        }
        default:
            break;
    }
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
                 [self.busStopsArray addObject:busStop];
             }
             [self.mapView showAnnotations:self.mapView.annotations animated:YES];
             [self.tableView reloadData];
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

    BusStopAnnotation *busStopAnnotaion = (BusStopAnnotation *)annotation;
    if (busStopAnnotaion.interModal)
    {
        if ([busStopAnnotaion.interModal isEqualToString:@"Metra"])
        {
            UIImageView *customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"metra"]];
            pin.leftCalloutAccessoryView = customImageView;
        }
        else
        {
            UIImageView *customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pace"]];
            pin.leftCalloutAccessoryView = customImageView;
        }
    }
    else
    {
        UIImageView *customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"no_connection"]];
        pin.leftCalloutAccessoryView = customImageView;
    }

    // Uncomment to add an image to the annotation leftCalloutAccessoryView
//    UIImageView *customImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"metra"]];
//    pin.leftCalloutAccessoryView = customImageView;

    return pin;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    [self performSegueWithIdentifier:@"AnnotationSegue" sender:view];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)annotationView
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    BusStopDetailViewController *busStopDetailViewController = segue.destinationViewController;

    if ([segue.identifier isEqualToString:@"AnnotationSegue"])
    {
        busStopDetailViewController.busStopAnnotation = annotationView.annotation;
    }
    else if ([segue.identifier isEqualToString:@"TableViewSegue"])
    {
        busStopDetailViewController.busStopAnnotation = [self.busStopsArray objectAtIndex:indexPath.row];
    }
}

#pragma mark - TableView Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.busStopsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    BusStopAnnotation *annotation = [self.busStopsArray objectAtIndex:indexPath.row];
    if (annotation.interModal)
    {
        if ([annotation.interModal isEqualToString:@"Metra"])
        {
            cell.imageView.image = [UIImage imageNamed:@"metra"];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:@"pace"];
        }
    }
    else
    {
        cell.imageView.image = [UIImage imageNamed:@"no_connection"];
    }

    cell.textLabel.text = annotation.title;
    cell.detailTextLabel.text = annotation.routes;
    return cell;
}


@end
