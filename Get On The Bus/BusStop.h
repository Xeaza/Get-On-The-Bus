//
//  Bus.h
//  Get On The Bus
//
//  Created by Taylor Wright-Sanson on 10/14/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BusStop : NSObject

@property NSURL *addressUrl;
@property NSInteger busId;
@property NSInteger position;
@property NSString *uuid;
@property NSString *ctaStop;
@property NSString *direction;
@property CLLocationCoordinate2D coord;
@property NSArray *routes;
@property NSInteger stopId;
@property NSInteger ward;

- (instancetype)initWithJSONDict: (NSDictionary *)busJSONDict;

@end
