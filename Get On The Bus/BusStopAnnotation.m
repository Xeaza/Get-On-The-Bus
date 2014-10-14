//
//  Bus.m
//  Get On The Bus
//
//  Created by Taylor Wright-Sanson on 10/14/14.
//  Copyright (c) 2014 Taylor Wright-Sanson. All rights reserved.
//

#import "BusStopAnnotation.h"

@implementation BusStopAnnotation {
    NSDictionary *json;
}

- (instancetype)initWithJSONDict: (NSDictionary *)busJSONDict
{
    self = [super init];
    if (self)
    {
        json = busJSONDict;
    }
    return self;
}

- (NSURL *)addressUrl {
    return [NSURL URLWithString:json[@"_address"]];
}

- (NSInteger)busId {
    return [json[@"_id"] integerValue];
}

- (NSInteger)position {
    return [json[@"_position"] integerValue];
}

- (NSString *)uuid {
    return json[@"_uuid"];
}

- (NSString *)direction {
    return json[@"direction"];
}

- (CLLocationCoordinate2D)coordinate {
    CLLocationCoordinate2D coordNew;
    coordNew.latitude  = [json[@"latitude"] doubleValue];
    double longitude = [json[@"longitude"] doubleValue];
    // There's one value in our data that isn't negitive and it should be
    // Make it so!
    if (longitude < 0) {
        coordNew.longitude = longitude;
    }
    else {
        coordNew.longitude = -longitude;
    }
    return coordNew;
}

- (NSString *)routes {
    return json[@"routes"];
}

- (NSInteger)stopId {
    return [json[@"stop_id"] integerValue];
}

- (NSInteger)ward {
    return [json[@"ward"] integerValue];
}

- (NSString *)title {
    return json[@"cta_stop_name"];
}

- (NSString *)subtitle {
    NSString *routes = [@"Routs: " stringByAppendingString:[self routes]];
    return routes;
}


@end
