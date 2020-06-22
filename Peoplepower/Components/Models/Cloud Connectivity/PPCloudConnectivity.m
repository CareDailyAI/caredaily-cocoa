//
//  PPCloudConnectivity.m
//  Peoplepower
//
//  Created by Destry Teeter on 3/22/18.
//  Copyright © 2020 People Power Company. All rights reserved.
//

#import "PPCloudConnectivity.h"
#import "PPCloudEngine.h"
#import "PPCurlDebug.h"
#import <KissXML/KissXML.h>

static NSTimeInterval kSystemStartTimeInterval = 1262304000; // 2010-01-01T00:00:00Z
static NSTimeInterval kSystemEndTimeInterval   = 5000000000; // 2128-06-11T08:53:20T

@implementation PPCloudConnectivity

#pragma mark - How to ping

+ (NSDate *)serverStartDate {
    return [NSDate dateWithTimeIntervalSince1970:kSystemStartTimeInterval];
}

+ (NSDate *)serverEndDate {
    return [NSDate dateWithTimeIntervalSince1970:kSystemEndTimeInterval];
}

/**
 * Check Availability.
 * Ping is disabled on all deployed instances of the IoT Software Suite for security reasons. We use an HTTP GET request to check for cloud availability, which returns "OK" if the IoT Software Suite instance is available. Combine this with the "time" Linux command to measure the response time of the IoT Software Suite.
 *
 * @param callback PPCloudConnectivityAvailabilityBlock Availability callback block
 **/
+ (void)checkAvailability:(PPCloudConnectivityAvailabilityBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithString:@"watch"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.cloud.checkAvailability()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedDefaultEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSString *status = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];

            PPLogAPI(@"%@", [PPCurlDebug responseToDescription:@{@"status":status}]);
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(status, nil);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Available Server Instances

/**
 * Get Connection Settings.
 *
 * @param deviceId NSString When specified, the API will return connection settings for this device. For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server,
 *      - true - return the server, where the device is connected now or nothing.
 *      Default false for all except streaming API, where it will try to find the server, where the device is connected first.
 * @param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @param callback PPCloudConnectivityCloudsBlock Clouds callback block
 **/
+ (void)getConnectionSettings:(NSString *)deviceId connected:(PPCloudConnectivityConnected)connected version:(PPCloudConnectivityVersion)version callback:(PPCloudConnectivityCloudsBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"settings"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(connected != PPCloudConnectivityConnectedNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"connected" value:(connected) ? @"true" : @"false"]];
    }
    if(version != PPCloudConnectivityVersionNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"version" value:@(version).stringValue]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.cloud.getConnectionSettings()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            NSMutableArray *clouds;
            
            if(!error) {
                clouds = [[NSMutableArray alloc] initWithCapacity:0];
                for(NSDictionary *cloudDict in [root objectForKey:@"clouds"]) {
                    PPCloudConnectivityCloud *cloud = [PPCloudConnectivityCloud initWithDictionary:cloudDict];
                    [clouds addObject:cloud];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(clouds, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Server Instances

/**
 * Get server.
 * This API returns just one server connection settings by type.
 *
 * @param type Required NSString Server type
 * @param deviceId NSString Device ID to receive device server For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server - default,
 *      - true - return the server, where the device is connected now or nothing.
 * @param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @param brand NSString Return brand specific server, if available.
 * @param appName NSString Return app specific server, if available.
 * @param callback PPCloudConnectivityServerBlock Server callback block
 **/
+ (void)getServer:(NSString *)type deviceId:(NSString *)deviceId connected:(PPCloudConnectivityConnected)connected version:(PPCloudConnectivityVersion)version brand:(NSString *)brand appName:(NSString *)appName callback:(PPCloudConnectivityServerBlock)callback {
    NSAssert1(type != nil, @"%s missing type", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"settingsServer/%@", type]] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(connected != PPCloudConnectivityConnectedNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"connected" value:(connected) ? @"true" : @"false"]];
    }
    if(version != PPCloudConnectivityVersionNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"version" value:@(version).stringValue]];
    }
    if(brand) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"brand" value:brand]];
    }
    if(appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    components.queryItems = queryItems;
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.cloud.getServer()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCloudConnectivityServer *server;
            
            if(!error) {
                if([root objectForKey:@"server"]) {
                     server = [PPCloudConnectivityServer initWithDictionary:[root objectForKey:@"server"]];
                }
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(server, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

/**
 * Get server URL.
 * This API returns just one server connection url by type.
 *
 * @param type Required NSString Server type
 * @param deviceId NSString Device ID to receive device server For maximum scalability, we recommend a device check in with this API every hour to discover, if it needs to switch servers.
 * @param connected PPCloudConnectivityConnected Check, if the device is connected to the server:
 *      - false - return the best available server - default,
 *      - true - return the server, where the device is connected now or nothing.
 * @param ssl Required PPCloudConnectivitySSL Flag to return SSL version of the URL, if available
 * @param version PPCloudConnectivityVersion When specified, the API will return only server of this version and non-version servers.
 * @param brand NSString Return brand specific server, if available.
 * @param appName NSString Return app specific server, if available.
 * @param callback PPCloudConnectivityServerBlock Server callback block
 **/
+ (void)getServerURL:(NSString *)type deviceId:(NSString *)deviceId connected:(PPCloudConnectivityConnected)connected ssl:(PPCloudConnectivitySSL)ssl version:(PPCloudConnectivityVersion)version brand:(NSString *)brand appName:(NSString *)appName callback:(PPCloudConnectivityServerURLBlock)callback {
    NSAssert1(type != nil, @"%s missing type", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"settingsServer"] resolvingAgainstBaseURL:NO];
    
    NSMutableArray *queryItems = @[].mutableCopy;
    [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"type" value:type]];
    
    if(deviceId) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    }
    if(connected != PPCloudConnectivityConnectedNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"connected" value:(connected) ? @"true" : @"false"]];
    }
    if(version != PPCloudConnectivityVersionNone) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"version" value:@(version).stringValue]];
    }
    if(brand) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"brand" value:brand]];
    }
    if(appName) {
        [queryItems addObject:[[NSURLQueryItem alloc] initWithName:@"appName" value:appName]];
    }
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.cloud.getServerURL()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));

    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSString *urlString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            PPLogAPI(@"%@", [PPCurlDebug responseToDescription:@{@"status":urlString}]);
            
            NSURL *url = [NSURL URLWithString:urlString];
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(url, nil);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Cloud Instances

/**
 * Get Cloud Instance.
 * Return the Cloud instance where this specific device should be pointed.
 * This API must be called only after the first initial device start and/or after a factory reset.
 *
 * @param deviceId Required deviceId NSString Device ID
 * @param callback PPCloudConnectivityCloudBlock Cloud callback block
 **/
+ (void)getCloudInstance:(NSString *)deviceId callback:(PPCloudConnectivityCloudBlock)callback {
    NSAssert1(deviceId != nil, @"%s missing deviceId", __FUNCTION__);
    NSURLComponents *components = [NSURLComponents componentsWithURL:[NSURL URLWithString:@"settingsCloud"] resolvingAgainstBaseURL:NO];
    components.queryItems = @[[[NSURLQueryItem alloc] initWithName:@"deviceId" value:deviceId]];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.cloud.getCloudInstances()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedAppEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSError *error = nil;
            NSDictionary *root = [PPBaseModel processJSONResponse:responseData originatingClass:NSStringFromClass([self class]) error:&error];
            
            PPCloudConnectivityCloud *cloud;
            
            if(!error) {
                cloud = [PPCloudConnectivityCloud initWithDictionary:root];
            }
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(cloud, error);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

#pragma mark - Version Information

/**
 * Get server version information.
 *
 * @param callback PPCloudConnectivityVersionBlock Version callback block
 **/
+ (void)getVersionInformation:(PPCloudConnectivityVersionBlock)callback {
    NSURLComponents *components = [NSURLComponents componentsWithString:@"version"];
    
    dispatch_queue_t queue = dispatch_queue_create("com.peoplepowerco.lib.Peoplepower.cloud.getVersionInformation()", DISPATCH_QUEUE_SERIAL);
    
    PPLogAPI(@"> %s", dispatch_queue_get_label(queue));
    
    [[PPCloudEngine sharedDefaultEngine] GET:components.string success:^(NSData *responseData) {
        
        dispatch_async(queue, ^{
            
            NSString *str = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
            
            NSError *error = nil;
            DDXMLElement *modules = [[DDXMLElement alloc] initWithXMLString:str error:&error];
            DDXMLNode *versionNode = [[modules nodesForXPath:@"espapi/version" error:&error] firstObject];
            DDXMLNode *revisionNode = [[modules nodesForXPath:@"espapi/revision" error:&error] firstObject];
            
            NSMutableString *serverVersion;
            if (!error) {
                NSString *version = [versionNode stringValue];
                NSString *revision = [revisionNode stringValue];
                
                serverVersion = @"".mutableCopy;
                if (version) {
                    [serverVersion appendString:version];
                }
                if (revision) {
                    [serverVersion appendFormat:@".%@", revision];
                }
            }
            
            PPLogAPI(@"%@", [PPCurlDebug responseToDescription:@{@"xml":str}]);
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(serverVersion, nil);
            });
        });
    } failure:^(NSError *error) {
        
        dispatch_async(queue, ^{
            
            PPLogAPI(@"< %s", dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL));
            
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(nil, [PPBaseModel resultCodeToNSError:10003 originatingClass:NSStringFromClass([self class]) argument:[NSString stringWithFormat:@"%@",error.userInfo]]);
            });
        });
    }];
}

@end
