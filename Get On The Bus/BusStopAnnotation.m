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
    coordNew.longitude = [json[@"longitude"] doubleValue];
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
    NSString *route = @"Routes: ";
    NSString *routes = [route stringByAppendingString:[self routes]];
    return routes;
}


@end
