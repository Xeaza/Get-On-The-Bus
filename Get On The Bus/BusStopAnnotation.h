//
//  Bus.h
//  Get On The Bus
//
//  Created by Taylor Wright-Sanson on 10/14/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusStopAnnotation : NSObject <MKAnnotation>

@property (readonly) NSURL *addressUrl;
@property (readonly) NSInteger busId;
@property (readonly) NSInteger position;
@property (readonly) NSString *uuid;
@property (readonly) NSString *direction;
@property (readonly) NSString *routes;
@property (readonly) NSInteger stopId;
@property (readonly) NSInteger ward;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;


- (instancetype)initWithJSONDict: (NSDictionary *)busJSONDict;

@end
