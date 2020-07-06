//
//  PPCloudConnectivityCloud.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCloudConnectivityCloud.h"

@implementation PPCloudConnectivityCloud

- (id)initWithCloud:(NSString *)cloud
               name:(NSString *)name
        currentTime:(NSDate *)currentTime
           timezone:(PPTimezone *)timezone
            servers:(NSArray *)servers
            version:(NSString *)version {
    self = [super init];
    if(self) {
        self.cloud = cloud;
        self.name = name;
        self.currentTime = currentTime;
        self.timezone = timezone;
        self.servers = servers;
        self.version = version;
    }
    return self;
}

+ (PPCloudConnectivityCloud *)initWithDictionary:(NSDictionary *)cloudDict {
    NSString *cloudEndpoint = [cloudDict objectForKey:@"cloud"];
    NSString *name = [cloudDict objectForKey:@"name"];
        
    NSString *currentTimeString = [cloudDict objectForKey:@"currentTime"];
    NSDate *currentTime = [NSDate date];
    
    if(currentTimeString != nil) {
        if(![currentTimeString isEqualToString:@""]) {
            currentTime = [PPNSDate parseDateTime:currentTimeString];
        }
    }
    
    PPTimezone *timezone = [PPTimezone initWithDictionary:[cloudDict objectForKey:@"defaultTimezone"]];
    
    
    NSMutableArray *servers;
    if([cloudDict objectForKey:@"servers"]) {
        servers = [[NSMutableArray alloc] initWithCapacity:0];
        for(NSDictionary *serverDict in [cloudDict objectForKey:@"servers"]) {
            PPCloudConnectivityServer *server = [PPCloudConnectivityServer initWithDictionary:serverDict];
            [servers addObject:server];
        }
    }
    
    NSString *version = [cloudDict objectForKey:@"version"];
    
    PPCloudConnectivityCloud *cloud = [[PPCloudConnectivityCloud alloc] initWithCloud:cloudEndpoint
                                                                                 name:name
                                                                          currentTime:currentTime
                                                                             timezone:timezone
                                                                              servers:servers
                                                                              version:version];
    return cloud;
}

#pragma mark - Encoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if(self) {
        self.cloud = [decoder decodeObjectForKey:@"cloud"];
        self.name = [decoder decodeObjectForKey:@"name"];
        self.currentTime = [decoder decodeObjectForKey:@"currentTime"];
        self.timezone = [decoder decodeObjectForKey:@"timezone"];
        self.servers = [decoder decodeObjectForKey:@"servers"];
        self.version = [decoder decodeObjectForKey:@"version"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:_cloud forKey:@"cloud"];
    [encoder encodeObject:_name forKey:@"name"];
    [encoder encodeObject:_currentTime forKey:@"currentTime"];
    [encoder encodeObject:_timezone forKey:@"timezone"];
    [encoder encodeObject:_servers forKey:@"servers"];
    [encoder encodeObject:_version forKey:@"version"];
}

@end
