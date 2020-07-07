//
//  PPCloudConnectivityCloud.h
//  Peoplepower
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPBaseModel.h"
#import "PPCloudConnectivityServer.h"
#import "PPTimezone.h"

@interface PPCloudConnectivityCloud : PPBaseModel

@property (nonatomic, strong) NSString *cloud;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSDate *currentTime;
@property (nonatomic, strong) PPTimezone *timezone;
@property (nonatomic, strong) RLMArray<PPCloudConnectivityServer *><PPCloudConnectivityServer> *servers;
@property (nonatomic, strong) NSString *version;

- (id)initWithCloud:(NSString *)cloud 
               name:(NSString *)name 
        currentTime:(NSDate *)currentTime 
           timezone:(PPTimezone *)timezone 
            servers:(RLMArray *)servers
            version:(NSString *)version;

+ (PPCloudConnectivityCloud *)initWithDictionary:(NSDictionary *)cloudDict;

@end

