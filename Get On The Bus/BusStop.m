//
//  Bus.m
//  Get On The Bus
//
//  Created by Taylor Wright-Sanson on 10/14/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "BusStop.h"

@implementation BusStop

- (instancetype)initWithJSONDict: (NSDictionary *)busJSONDict
{
    self = [super init];
    if (self)
    {
        self.addressUrl        = [NSURL URLWithString:busJSONDict[@"_address"]];
        self.busId             = [busJSONDict[@"_id"] integerValue];
        self.position          = [busJSONDict[@"_position"] integerValue];
        self.uuid              = busJSONDict[@"_uuid"];
        self.ctaStop           = busJSONDict[@"cta_stop_name"];
        self.direction         = busJSONDict[@"direction"];

        CLLocationCoordinate2D coord;
        coord.latitude  = [busJSONDict[@"latitude"] doubleValue];
        coord.longitude = [busJSONDict[@"longitude"] doubleValue];
        self.coord      = coord;
        NSLog(@"%f, %f", self.coord.latitude, self.coord.longitude);
        NSString *routesString = busJSONDict[@"routes"];
        self.routes            = [routesString componentsSeparatedByString:@","];;
        self.stopId            = [busJSONDict[@"stop_id"] integerValue];
        self.ward              = [busJSONDict[@"ward"] integerValue];
    }
    return self;
}

@end
